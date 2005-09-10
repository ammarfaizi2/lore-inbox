Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbVIJWei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbVIJWei (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbVIJWe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:34:29 -0400
Received: from styx.suse.cz ([82.119.242.94]:41892 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932365AbVIJWdx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:33:53 -0400
Subject: [PATCH 25/26] clean up whitespace and formatting in drivers/char/keyboard.c
In-Reply-To: <11263916543880@midnight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sun, 11 Sep 2005 00:34:14 +0200
Message-Id: <11263916542240@midnight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] Input: clean up whitespace and formatting in drivers/char/keyboard.c
From: Dmitry Torokhov <dtor_core@ameritech.net>
Date: 1126371818 -0500

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

---

 drivers/char/keyboard.c |  109 ++++++++++++++++++++++++-----------------------
 1 files changed, 55 insertions(+), 54 deletions(-)

fe1e86049813641a518d15adf7191bd711b4f611
diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -14,7 +14,7 @@
  * `Sticky' modifier keys, 951006.
  *
  * 11-11-96: SAK should now work in the raw mode (Martin Mares)
- * 
+ *
  * Modified to provide 'generic' keyboard support by Hamish Macdonald
  * Merge with the m68k keyboard driver and split-off of the PC low-level
  * parts by Geert Uytterhoeven, May 1997
@@ -52,7 +52,7 @@ extern void ctrl_alt_del(void);
 /*
  * Some laptops take the 789uiojklm,. keys as number pad when NumLock is on.
  * This seems a good reason to start with NumLock off. On HIL keyboards
- * of PARISC machines however there is no NumLock key and everyone expects the keypad 
+ * of PARISC machines however there is no NumLock key and everyone expects the keypad
  * to be used for numbers.
  */
 
@@ -76,17 +76,17 @@ void compute_shiftstate(void);
 	k_meta,		k_ascii,	k_lock,		k_lowercase,\
 	k_slock,	k_dead2,	k_ignore,	k_ignore
 
-typedef void (k_handler_fn)(struct vc_data *vc, unsigned char value, 
+typedef void (k_handler_fn)(struct vc_data *vc, unsigned char value,
 			    char up_flag, struct pt_regs *regs);
 static k_handler_fn K_HANDLERS;
 static k_handler_fn *k_handler[16] = { K_HANDLERS };
 
 #define FN_HANDLERS\
-	fn_null, 	fn_enter,	fn_show_ptregs,	fn_show_mem,\
-	fn_show_state,	fn_send_intr, 	fn_lastcons, 	fn_caps_toggle,\
-	fn_num,		fn_hold, 	fn_scroll_forw,	fn_scroll_back,\
-	fn_boot_it, 	fn_caps_on, 	fn_compose,	fn_SAK,\
-	fn_dec_console, fn_inc_console, fn_spawn_con, 	fn_bare_num
+	fn_null,	fn_enter,	fn_show_ptregs,	fn_show_mem,\
+	fn_show_state,	fn_send_intr,	fn_lastcons,	fn_caps_toggle,\
+	fn_num,		fn_hold,	fn_scroll_forw,	fn_scroll_back,\
+	fn_boot_it,	fn_caps_on,	fn_compose,	fn_SAK,\
+	fn_dec_console, fn_inc_console, fn_spawn_con,	fn_bare_num
 
 typedef void (fn_handler_fn)(struct vc_data *vc, struct pt_regs *regs);
 static fn_handler_fn FN_HANDLERS;
@@ -159,13 +159,13 @@ static int sysrq_alt;
  */
 int getkeycode(unsigned int scancode)
 {
-	struct list_head * node;
+	struct list_head *node;
 	struct input_dev *dev = NULL;
 
-	list_for_each(node,&kbd_handler.h_list) {
-		struct input_handle * handle = to_handle_h(node);
-		if (handle->dev->keycodesize) { 
-			dev = handle->dev; 
+	list_for_each(node, &kbd_handler.h_list) {
+		struct input_handle *handle = to_handle_h(node);
+		if (handle->dev->keycodesize) {
+			dev = handle->dev;
 			break;
 		}
 	}
@@ -181,15 +181,15 @@ int getkeycode(unsigned int scancode)
 
 int setkeycode(unsigned int scancode, unsigned int keycode)
 {
-	struct list_head * node;
+	struct list_head *node;
 	struct input_dev *dev = NULL;
 	unsigned int i, oldkey;
 
-	list_for_each(node,&kbd_handler.h_list) {
+	list_for_each(node, &kbd_handler.h_list) {
 		struct input_handle *handle = to_handle_h(node);
-		if (handle->dev->keycodesize) { 
-			dev = handle->dev; 
-			break; 
+		if (handle->dev->keycodesize) {
+			dev = handle->dev;
+			break;
 		}
 	}
 
@@ -216,11 +216,11 @@ int setkeycode(unsigned int scancode, un
 }
 
 /*
- * Making beeps and bells. 
+ * Making beeps and bells.
  */
 static void kd_nosound(unsigned long ignored)
 {
-	struct list_head * node;
+	struct list_head *node;
 
 	list_for_each(node,&kbd_handler.h_list) {
 		struct input_handle *handle = to_handle_h(node);
@@ -237,12 +237,12 @@ static DEFINE_TIMER(kd_mksound_timer, kd
 
 void kd_mksound(unsigned int hz, unsigned int ticks)
 {
-	struct list_head * node;
+	struct list_head *node;
 
 	del_timer(&kd_mksound_timer);
 
 	if (hz) {
-		list_for_each_prev(node,&kbd_handler.h_list) {
+		list_for_each_prev(node, &kbd_handler.h_list) {
 			struct input_handle *handle = to_handle_h(node);
 			if (test_bit(EV_SND, handle->dev->evbit)) {
 				if (test_bit(SND_TONE, handle->dev->sndbit)) {
@@ -337,19 +337,19 @@ static void to_utf8(struct vc_data *vc, 
 	if (c < 0x80)
 		/*  0******* */
 		put_queue(vc, c);
-    	else if (c < 0x800) {
+	else if (c < 0x800) {
 		/* 110***** 10****** */
-		put_queue(vc, 0xc0 | (c >> 6)); 
+		put_queue(vc, 0xc0 | (c >> 6));
 		put_queue(vc, 0x80 | (c & 0x3f));
-    	} else {
+	} else {
 		/* 1110**** 10****** 10****** */
 		put_queue(vc, 0xe0 | (c >> 12));
 		put_queue(vc, 0x80 | ((c >> 6) & 0x3f));
 		put_queue(vc, 0x80 | (c & 0x3f));
-    	}
+	}
 }
 
-/* 
+/*
  * Called after returning from RAW mode or when changing consoles - recompute
  * shift_down[] and shift_state from key_down[] maybe called when keymap is
  * undefined, so that shiftkey release is seen
@@ -360,7 +360,7 @@ void compute_shiftstate(void)
 
 	shift_state = 0;
 	memset(shift_down, 0, sizeof(shift_down));
-	
+
 	for (i = 0; i < ARRAY_SIZE(key_down); i++) {
 
 		if (!key_down[i])
@@ -499,9 +499,9 @@ static void fn_dec_console(struct vc_dat
 	if (want_console != -1)
 		cur = want_console;
 
-	for (i = cur-1; i != cur; i--) {
+	for (i = cur - 1; i != cur; i--) {
 		if (i == -1)
-			i = MAX_NR_CONSOLES-1;
+			i = MAX_NR_CONSOLES - 1;
 		if (vc_cons_allocated(i))
 			break;
 	}
@@ -567,9 +567,9 @@ static void fn_compose(struct vc_data *v
 
 static void fn_spawn_con(struct vc_data *vc, struct pt_regs *regs)
 {
-        if (spawnpid)
-	   if(kill_proc(spawnpid, spawnsig, 1))
-	     spawnpid = 0;
+	if (spawnpid)
+		if (kill_proc(spawnpid, spawnsig, 1))
+			spawnpid = 0;
 }
 
 static void fn_SAK(struct vc_data *vc, struct pt_regs *regs)
@@ -603,8 +603,8 @@ static void k_spec(struct vc_data *vc, u
 		return;
 	if (value >= ARRAY_SIZE(fn_handler))
 		return;
-	if ((kbd->kbdmode == VC_RAW || 
-	     kbd->kbdmode == VC_MEDIUMRAW) && 
+	if ((kbd->kbdmode == VC_RAW ||
+	     kbd->kbdmode == VC_MEDIUMRAW) &&
 	     value != KVAL(K_SAK))
 		return;		/* SAK is allowed even in raw mode */
 	fn_handler[value](vc, regs);
@@ -894,11 +894,11 @@ static inline unsigned char getleds(void
 
 static void kbd_bh(unsigned long dummy)
 {
-	struct list_head * node;
+	struct list_head *node;
 	unsigned char leds = getleds();
 
 	if (leds != ledstate) {
-		list_for_each(node,&kbd_handler.h_list) {
+		list_for_each(node, &kbd_handler.h_list) {
 			struct input_handle * handle = to_handle_h(node);
 			input_event(handle->dev, EV_LED, LED_SCROLLL, !!(leds & 0x01));
 			input_event(handle->dev, EV_LED, LED_NUML,    !!(leds & 0x02));
@@ -963,11 +963,11 @@ static int sparc_l1_a_state = 0;
 extern void sun_do_break(void);
 #endif
 
-static int emulate_raw(struct vc_data *vc, unsigned int keycode, 
+static int emulate_raw(struct vc_data *vc, unsigned int keycode,
 		       unsigned char up_flag)
 {
 	if (keycode > 255 || !x86_keycodes[keycode])
-		return -1; 
+		return -1;
 
 	switch (keycode) {
 		case KEY_PAUSE:
@@ -981,7 +981,7 @@ static int emulate_raw(struct vc_data *v
 		case KEY_HANJA:
 			if (!up_flag) put_queue(vc, 0xf2);
 			return 0;
-	} 
+	}
 
 	if (keycode == KEY_SYSRQ && sysrq_alt) {
 		put_queue(vc, 0x54 | up_flag);
@@ -1104,11 +1104,12 @@ static void kbd_keycode(unsigned int key
 	else
 		clear_bit(keycode, key_down);
 
-	if (rep && (!vc_kbd_mode(kbd, VC_REPEAT) || (tty && 
-		(!L_ECHO(tty) && tty->driver->chars_in_buffer(tty))))) {
+	if (rep &&
+	    (!vc_kbd_mode(kbd, VC_REPEAT) ||
+	     (tty && !L_ECHO(tty) && tty->driver->chars_in_buffer(tty)))) {
 		/*
 		 * Don't repeat a key if the input buffers are not empty and the
-		 * characters get aren't echoed locally. This makes key repeat 
+		 * characters get aren't echoed locally. This makes key repeat
 		 * usable with slow applications and under heavy loads.
 		 */
 		return;
@@ -1130,7 +1131,8 @@ static void kbd_keycode(unsigned int key
 	type = KTYP(keysym);
 
 	if (type < 0xf0) {
-		if (down && !raw_mode) to_utf8(vc, keysym);
+		if (down && !raw_mode)
+			to_utf8(vc, keysym);
 		return;
 	}
 
@@ -1154,7 +1156,7 @@ static void kbd_keycode(unsigned int key
 		kbd->slockstate = 0;
 }
 
-static void kbd_event(struct input_handle *handle, unsigned int event_type, 
+static void kbd_event(struct input_handle *handle, unsigned int event_type,
 		      unsigned int event_code, int value)
 {
 	if (event_type == EV_MSC && event_code == MSC_RAW && HW_RAW(handle->dev))
@@ -1166,15 +1168,13 @@ static void kbd_event(struct input_handl
 	schedule_console_callback();
 }
 
-static char kbd_name[] = "kbd";
-
 /*
  * When a keyboard (or other input device) is found, the kbd_connect
  * function is called. The function then looks at the device, and if it
  * likes it, it can open it and get events from it. In this (kbd_connect)
  * function, we should decide which VT to bind that keyboard to initially.
  */
-static struct input_handle *kbd_connect(struct input_handler *handler, 
+static struct input_handle *kbd_connect(struct input_handler *handler,
 					struct input_dev *dev,
 					struct input_device_id *id)
 {
@@ -1182,18 +1182,19 @@ static struct input_handle *kbd_connect(
 	int i;
 
 	for (i = KEY_RESERVED; i < BTN_MISC; i++)
-		if (test_bit(i, dev->keybit)) break;
+		if (test_bit(i, dev->keybit))
+			break;
 
-	if ((i == BTN_MISC) && !test_bit(EV_SND, dev->evbit)) 
+	if (i == BTN_MISC && !test_bit(EV_SND, dev->evbit))
 		return NULL;
 
-	if (!(handle = kmalloc(sizeof(struct input_handle), GFP_KERNEL))) 
+	if (!(handle = kmalloc(sizeof(struct input_handle), GFP_KERNEL)))
 		return NULL;
 	memset(handle, 0, sizeof(struct input_handle));
 
 	handle->dev = dev;
 	handle->handler = handler;
-	handle->name = kbd_name;
+	handle->name = "kbd";
 
 	input_open_device(handle);
 	kbd_refresh_leds(handle);
@@ -1212,11 +1213,11 @@ static struct input_device_id kbd_ids[] 
                 .flags = INPUT_DEVICE_ID_MATCH_EVBIT,
                 .evbit = { BIT(EV_KEY) },
         },
-	
+
 	{
                 .flags = INPUT_DEVICE_ID_MATCH_EVBIT,
                 .evbit = { BIT(EV_SND) },
-        },	
+        },
 
 	{ },    /* Terminating entry */
 };

