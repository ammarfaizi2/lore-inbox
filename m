Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262214AbVAODsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbVAODsx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 22:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbVAODsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 22:48:52 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:51393 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262214AbVAODkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 22:40:47 -0500
Date: Sat, 15 Jan 2005 04:40:34 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Christoph Hellwig <hch@lst.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] remove console_macros.h
In-Reply-To: <20041231143457.GA9165@lst.de>
Message-ID: <Pine.LNX.4.61.0501150439170.6118@scrub.home>
References: <20041231143457.GA9165@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Remove the macros in console_macros.h and so make the structure references 
explicit.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

 drivers/char/console_macros.h  |   71 --
 linux-2.6-vc/drivers/char/vt.c | 1035 ++++++++++++++++++++---------------------
 2 files changed, 523 insertions(+), 583 deletions(-)

Index: linux-2.6-vc/drivers/char/console_macros.h
===================================================================
--- linux-2.6-vc.orig/drivers/char/console_macros.h	2005-01-14 22:15:55.896858073 +0100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,71 +0,0 @@
-#define cons_num	(vc->vc_num)
-#define video_scan_lines (vc->vc_scan_lines)
-#define sw		(vc->vc_sw)
-#define screenbuf	(vc->vc_screenbuf)
-#define screenbuf_size	(vc->vc_screenbuf_size)
-#define origin		(vc->vc_origin)
-#define scr_top		(vc->vc_scr_top)
-#define visible_origin  (vc->vc_visible_origin)
-#define scr_end		(vc->vc_scr_end)
-#define pos		(vc->vc_pos)
-#define top		(vc->vc_top)
-#define bottom		(vc->vc_bottom)
-#define x		(vc->vc_x)
-#define y		(vc->vc_y)
-#define vc_state	(vc->vc_state)
-#define npar		(vc->vc_npar)
-#define par		(vc->vc_par)
-#define ques		(vc->vc_ques)
-#define attr		(vc->vc_attr)
-#define saved_x		(vc->vc_saved_x)
-#define saved_y		(vc->vc_saved_y)
-#define translate	(vc->vc_translate)
-#define G0_charset	(vc->vc_G0_charset)
-#define G1_charset	(vc->vc_G1_charset)
-#define saved_G0	(vc->vc_saved_G0)
-#define saved_G1	(vc->vc_saved_G1)
-#define utf		(vc->vc_utf)
-#define utf_count	(vc->vc_utf_count)
-#define utf_char	(vc->vc_utf_char)
-#define video_erase_char (vc->vc_video_erase_char)
-#define disp_ctrl	(vc->vc_disp_ctrl)
-#define toggle_meta	(vc->vc_toggle_meta)
-#define decscnm		(vc->vc_decscnm)
-#define decom		(vc->vc_decom)
-#define decawm		(vc->vc_decawm)
-#define deccm		(vc->vc_deccm)
-#define decim		(vc->vc_decim)
-#define deccolm		(vc->vc_deccolm)
-#define need_wrap	(vc->vc_need_wrap)
-#define kmalloced	(vc->vc_kmalloced)
-#define report_mouse	(vc->vc_report_mouse)
-#define color		(vc->vc_color)
-#define s_color		(vc->vc_s_color)
-#define def_color	(vc->vc_def_color)
-#define foreground	(color & 0x0f)
-#define background	(color & 0xf0)
-#define charset		(vc->vc_charset)
-#define s_charset	(vc->vc_s_charset)
-#define	intensity	(vc->vc_intensity)
-#define	underline	(vc->vc_underline)
-#define	blink		(vc->vc_blink)
-#define	reverse		(vc->vc_reverse)
-#define	s_intensity	(vc->vc_s_intensity)
-#define	s_underline	(vc->vc_s_underline)
-#define	s_blink		(vc->vc_s_blink)
-#define	s_reverse	(vc->vc_s_reverse)
-#define	ulcolor		(vc->vc_ulcolor)
-#define	halfcolor	(vc->vc_halfcolor)
-#define tab_stop	(vc->vc_tab_stop)
-#define palette		(vc->vc_palette)
-#define bell_pitch	(vc->vc_bell_pitch)
-#define bell_duration	(vc->vc_bell_duration)
-#define cursor_type	(vc->vc_cursor_type)
-#define display_fg	(vc->vc_display_fg)
-#define complement_mask (vc->vc_complement_mask)
-#define s_complement_mask (vc->vc_s_complement_mask)
-#define hi_font_mask	(vc->vc_hi_font_mask)
-
-#define vcmode		(vt_cons[vc->vc_num]->vc_mode)
-
-#define structsize	(sizeof(struct vc_data) + sizeof(struct vt_struct))
Index: linux-2.6-vc/drivers/char/vt.c
===================================================================
--- linux-2.6-vc.orig/drivers/char/vt.c	2005-01-14 22:15:55.894858418 +0100
+++ linux-2.6-vc/drivers/char/vt.c	2005-01-14 22:16:13.448833821 +0100
@@ -98,8 +98,6 @@
 #include <asm/system.h>
 #include <asm/uaccess.h>
 
-#include "console_macros.h"
-
 
 const struct consw *conswitchp;
 
@@ -255,12 +253,12 @@ static void scrup(struct vc_data *vc, un
 		nr = b - t - 1;
 	if (b > vc->vc_rows || t >= b || nr < 1)
 		return;
-	if (CON_IS_VISIBLE(vc) && sw->con_scroll(vc, t, b, SM_UP, nr))
+	if (CON_IS_VISIBLE(vc) && vc->vc_sw->con_scroll(vc, t, b, SM_UP, nr))
 		return;
-	d = (unsigned short *)(origin + vc->vc_size_row * t);
-	s = (unsigned short *)(origin + vc->vc_size_row * (t + nr));
+	d = (unsigned short *)(vc->vc_origin + vc->vc_size_row * t);
+	s = (unsigned short *)(vc->vc_origin + vc->vc_size_row * (t + nr));
 	scr_memmovew(d, s, (b - t - nr) * vc->vc_size_row);
-	scr_memsetw(d + (b - t - nr) * vc->vc_cols, video_erase_char,
+	scr_memsetw(d + (b - t - nr) * vc->vc_cols, vc->vc_video_erase_char,
 		    vc->vc_size_row * nr);
 }
 
@@ -273,12 +271,12 @@ static void scrdown(struct vc_data *vc, 
 		nr = b - t - 1;
 	if (b > vc->vc_rows || t >= b || nr < 1)
 		return;
-	if (CON_IS_VISIBLE(vc) && sw->con_scroll(vc, t, b, SM_DOWN, nr))
+	if (CON_IS_VISIBLE(vc) && vc->vc_sw->con_scroll(vc, t, b, SM_DOWN, nr))
 		return;
-	s = (unsigned short *)(origin + vc->vc_size_row * t);
+	s = (unsigned short *)(vc->vc_origin + vc->vc_size_row * t);
 	step = vc->vc_cols * nr;
 	scr_memmovew(s + step, s, (b - t - nr) * vc->vc_size_row);
-	scr_memsetw(s, video_erase_char, 2*step);
+	scr_memsetw(s, vc->vc_video_erase_char, 2 * step);
 }
 
 static void do_update_region(struct vc_data *vc, unsigned long start, int count)
@@ -342,8 +340,8 @@ void update_region(struct vc_data *vc, u
 
 static u8 build_attr(struct vc_data *vc, u8 _color, u8 _intensity, u8 _blink, u8 _underline, u8 _reverse)
 {
-	if (sw->con_build_attr)
-		return sw->con_build_attr(vc, _color, _intensity, _blink, _underline, _reverse);
+	if (vc->vc_sw->con_build_attr)
+		return vc->vc_sw->con_build_attr(vc, _color, _intensity, _blink, _underline, _reverse);
 
 #ifndef VT_BUF_VRAM_ONLY
 /*
@@ -357,23 +355,23 @@ static u8 build_attr(struct vc_data *vc,
  *  Bit 7   : blink
  */
 	{
-	u8 a = color;
+	u8 a = vc->vc_color;
 	if (!vc->vc_can_do_color)
 		return _intensity |
 		       (_underline ? 4 : 0) |
 		       (_reverse ? 8 : 0) |
 		       (_blink ? 0x80 : 0);
 	if (_underline)
-		a = (a & 0xf0) | ulcolor;
+		a = (a & 0xf0) | vc->vc_ulcolor;
 	else if (_intensity == 0)
-		a = (a & 0xf0) | halfcolor;
+		a = (a & 0xf0) | vc->vc_ulcolor;
 	if (_reverse)
 		a = ((a) & 0x88) | ((((a) >> 4) | ((a) << 4)) & 0x77);
 	if (_blink)
 		a ^= 0x80;
 	if (_intensity == 2)
 		a ^= 0x08;
-	if (hi_font_mask == 0x100)
+	if (vc->vc_hi_font_mask == 0x100)
 		a <<= 1;
 	return a;
 	}
@@ -384,8 +382,8 @@ static u8 build_attr(struct vc_data *vc,
 
 static void update_attr(struct vc_data *vc)
 {
-	attr = build_attr(vc, color, intensity, blink, underline, reverse ^ decscnm);
-	video_erase_char = (build_attr(vc, color, 1, blink, 0, decscnm) << 8) | ' ';
+	vc->vc_attr = build_attr(vc, vc->vc_color, vc->vc_intensity, vc->vc_blink, vc->vc_underline, vc->vc_reverse ^ vc->vc_decscnm);
+	vc->vc_video_erase_char = (build_attr(vc, vc->vc_color, 1, vc->vc_blink, 0, vc->vc_decscnm) << 8) | ' ';
 }
 
 /* Note: inverting the screen twice should revert to the original state */
@@ -465,44 +463,44 @@ void complement_pos(struct vc_data *vc, 
 
 static void insert_char(struct vc_data *vc, unsigned int nr)
 {
-	unsigned short *p, *q = (unsigned short *) pos;
+	unsigned short *p, *q = (unsigned short *)vc->vc_pos;
 
-	p = q + vc->vc_cols - nr - x;
+	p = q + vc->vc_cols - nr - vc->vc_x;
 	while (--p >= q)
 		scr_writew(scr_readw(p), p + nr);
-	scr_memsetw(q, video_erase_char, nr*2);
-	need_wrap = 0;
+	scr_memsetw(q, vc->vc_video_erase_char, nr * 2);
+	vc->vc_need_wrap = 0;
 	if (DO_UPDATE(vc)) {
-		unsigned short oldattr = attr;
-		sw->con_bmove(vc, y, x, y, x + nr, 1,
-			      vc->vc_cols - x - nr);
-		attr = video_erase_char >> 8;
+		unsigned short oldattr = vc->vc_attr;
+		vc->vc_sw->con_bmove(vc, vc->vc_y, vc->vc_x, vc->vc_y, vc->vc_x + nr, 1,
+				     vc->vc_cols - vc->vc_x - nr);
+		vc->vc_attr = vc->vc_video_erase_char >> 8;
 		while (nr--)
-			sw->con_putc(vc, video_erase_char, y, x + nr);
-		attr = oldattr;
+			vc->vc_sw->con_putc(vc, vc->vc_video_erase_char, vc->vc_y, vc->vc_x + nr);
+		vc->vc_attr = oldattr;
 	}
 }
 
 static void delete_char(struct vc_data *vc, unsigned int nr)
 {
-	unsigned int i = x;
-	unsigned short *p = (unsigned short *) pos;
+	unsigned int i = vc->vc_x;
+	unsigned short *p = (unsigned short *)vc->vc_pos;
 
 	while (++i <= vc->vc_cols - nr) {
 		scr_writew(scr_readw(p+nr), p);
 		p++;
 	}
-	scr_memsetw(p, video_erase_char, nr*2);
-	need_wrap = 0;
+	scr_memsetw(p, vc->vc_video_erase_char, nr * 2);
+	vc->vc_need_wrap = 0;
 	if (DO_UPDATE(vc)) {
-		unsigned short oldattr = attr;
-		sw->con_bmove(vc, y, x + nr, y, x, 1,
-			      vc->vc_cols - x - nr);
-		attr = video_erase_char >> 8;
+		unsigned short oldattr = vc->vc_attr;
+		vc->vc_sw->con_bmove(vc, vc->vc_y, vc->vc_x + nr, vc->vc_y, vc->vc_x, 1,
+				     vc->vc_cols - vc->vc_x - nr);
+		vc->vc_attr = vc->vc_video_erase_char >> 8;
 		while (nr--)
-			sw->con_putc(vc, video_erase_char, y,
+			vc->vc_sw->con_putc(vc, vc->vc_video_erase_char, vc->vc_y,
 				     vc->vc_cols - 1 - nr);
-		attr = oldattr;
+		vc->vc_attr = oldattr;
 	}
 }
 
@@ -564,20 +562,20 @@ static void set_origin(struct vc_data *v
 	WARN_CONSOLE_UNLOCKED();
 
 	if (!CON_IS_VISIBLE(vc) ||
-	    !sw->con_set_origin ||
-	    !sw->con_set_origin(vc))
-		origin = (unsigned long) screenbuf;
-	visible_origin = origin;
-	scr_end = origin + screenbuf_size;
-	pos = origin + vc->vc_size_row * y + 2 * x;
+	    !vc->vc_sw->con_set_origin ||
+	    !vc->vc_sw->con_set_origin(vc))
+		vc->vc_origin = (unsigned long)vc->vc_screenbuf;
+	vc->vc_visible_origin = vc->vc_origin;
+	vc->vc_scr_end = vc->vc_origin + vc->vc_screenbuf_size;
+	vc->vc_pos = vc->vc_origin + vc->vc_size_row * vc->vc_y + 2 * vc->vc_x;
 }
 
 static inline void save_screen(struct vc_data *vc)
 {
 	WARN_CONSOLE_UNLOCKED();
 
-	if (sw->con_save_screen)
-		sw->con_save_screen(vc);
+	if (vc->vc_sw->con_save_screen)
+		vc->vc_sw->con_save_screen(vc);
 }
 
 /*
@@ -586,12 +584,12 @@ static inline void save_screen(struct vc
 
 static void clear_buffer_attributes(struct vc_data *vc)
 {
-	unsigned short *p = (unsigned short *) origin;
-	int count = screenbuf_size/2;
-	int mask = hi_font_mask | 0xff;
+	unsigned short *p = (unsigned short *)vc->vc_origin;
+	int count = vc->vc_screenbuf_size / 2;
+	int mask = vc->vc_hi_font_mask | 0xff;
 
 	for (; count > 0; count--, p++) {
-		scr_writew((scr_readw(p)&mask) | (video_erase_char&~mask), p);
+		scr_writew((scr_readw(p)&mask) | (vc->vc_video_erase_char & ~mask), p);
 	}
 }
 
@@ -630,7 +628,7 @@ void redraw_screen(struct vc_data *vc, i
 		int old_was_color = vc->vc_can_do_color;
 
 		set_origin(vc);
-		update = sw->con_switch(vc);
+		update = vc->vc_sw->con_switch(vc);
 		set_palette(vc);
 		/*
 		 * If console changed from mono<->color, the best we can do
@@ -642,8 +640,8 @@ void redraw_screen(struct vc_data *vc, i
 			update_attr(vc);
 			clear_buffer_attributes(vc);
 		}
-		if (update && vcmode != KD_GRAPHICS)
-			do_update_region(vc, origin, screenbuf_size / 2);
+		if (update && vt_cons[vc->vc_num]->vc_mode != KD_GRAPHICS)
+			do_update_region(vc, vc->vc_origin, vc->vc_screenbuf_size / 2);
 	}
 	set_cursor(vc);
 	if (is_switch) {
@@ -663,28 +661,28 @@ int vc_cons_allocated(unsigned int i)
 
 static void visual_init(struct vc_data *vc, int num, int init)
 {
-	/* ++Geert: sw->con_init determines console size */
-	if (sw)
-		module_put(sw->owner);
-	sw = conswitchp;
+	/* ++Geert: vc->vc_sw->con_init determines console size */
+	if (vc->vc_sw)
+		module_put(vc->vc_sw->owner);
+	vc->vc_sw = conswitchp;
 #ifndef VT_SINGLE_DRIVER
 	if (con_driver_map[num])
-		sw = con_driver_map[num];
+		vc->vc_sw = con_driver_map[num];
 #endif
-	__module_get(sw->owner);
+	__module_get(vc->vc_sw->owner);
 	vc->vc_num = num;
-	display_fg = &master_display_fg;
+	vc->vc_display_fg = &master_display_fg;
 	vc->vc_uni_pagedir_loc = &vc->vc_uni_pagedir;
 	vc->vc_uni_pagedir = 0;
-	hi_font_mask = 0;
-	complement_mask = 0;
+	vc->vc_hi_font_mask = 0;
+	vc->vc_complement_mask = 0;
 	vc->vc_can_do_color = 0;
-	sw->con_init(vc, init);
-	if (!complement_mask)
-		complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
-	s_complement_mask = complement_mask;
+	vc->vc_sw->con_init(vc, init);
+	if (!vc->vc_complement_mask)
+		vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
+	vc->vc_s_complement_mask = vc->vc_complement_mask;
 	vc->vc_size_row = vc->vc_cols << 1;
-	screenbuf_size = vc->vc_rows * vc->vc_size_row;
+	vc->vc_screenbuf_size = vc->vc_rows * vc->vc_size_row;
 }
 
 int vc_allocate(unsigned int currcons)	/* return 0 on success */
@@ -707,25 +705,25 @@ int vc_allocate(unsigned int currcons)	/
 	    /* although the numbers above are not valid since long ago, the
 	       point is still up-to-date and the comment still has its value
 	       even if only as a historical artifact.  --mj, July 1998 */
-	    p = (long) kmalloc(structsize, GFP_KERNEL);
+	    p = (long) kmalloc(sizeof(struct vc_data) + sizeof(struct vt_struct), GFP_KERNEL);
 	    if (!p)
 		return -ENOMEM;
-	    memset((void *)p, 0, structsize);
+	    memset((void *)p, 0, sizeof(struct vc_data) + sizeof(struct vt_struct));
 	    vc_cons[currcons].d = vc = (struct vc_data *)p;
 	    vt_cons[currcons] = (struct vt_struct *)(p+sizeof(struct vc_data));
 	    vc_cons[currcons].d->vc_vt = vt_cons[currcons];
 	    visual_init(vc, currcons, 1);
 	    if (!*vc->vc_uni_pagedir_loc)
 		con_set_default_unimap(vc);
-	    q = (long)kmalloc(screenbuf_size, GFP_KERNEL);
+	    q = (long)kmalloc(vc->vc_screenbuf_size, GFP_KERNEL);
 	    if (!q) {
 		kfree((char *) p);
 		vc_cons[currcons].d = NULL;
 		vt_cons[currcons] = NULL;
 		return -ENOMEM;
 	    }
-	    screenbuf = (unsigned short *) q;
-	    kmalloced = 1;
+	    vc->vc_screenbuf = (unsigned short *)q;
+	    vc->vc_kmalloced = 1;
 	    vc_init(vc, vc->vc_rows, vc->vc_cols, 1);
 
 	    if (!pm_con) {
@@ -742,8 +740,8 @@ inline int resize_screen(struct vc_data 
 	/* Resizes the resolution of the display adapater */
 	int err = 0;
 
-	if (vcmode != KD_GRAPHICS && sw->con_resize)
-		err = sw->con_resize(vc, width, height);
+	if (vt_cons[vc->vc_num]->vc_mode != KD_GRAPHICS && vc->vc_sw->con_resize)
+		err = vc->vc_sw->con_resize(vc, width, height);
 	return err;
 }
 
@@ -784,7 +782,7 @@ int vc_resize(struct vc_data *vc, unsign
 	old_rows = vc->vc_rows;
 	old_cols = vc->vc_cols;
 	old_row_size = vc->vc_size_row;
-	old_screen_size = screenbuf_size;
+	old_screen_size = vc->vc_screenbuf_size;
 
 	err = resize_screen(vc, new_cols, new_rows);
 	if (err) {
@@ -795,11 +793,11 @@ int vc_resize(struct vc_data *vc, unsign
 	vc->vc_rows = new_rows;
 	vc->vc_cols = new_cols;
 	vc->vc_size_row = new_row_size;
-	screenbuf_size = new_screen_size;
+	vc->vc_screenbuf_size = new_screen_size;
 
 	rlth = min(old_row_size, new_row_size);
 	rrem = new_row_size - rlth;
-	old_origin = origin;
+	old_origin = vc->vc_origin;
 	new_origin = (long) newscreen;
 	new_scr_end = new_origin + new_screen_size;
 	if (new_rows < old_rows)
@@ -807,26 +805,26 @@ int vc_resize(struct vc_data *vc, unsign
 
 	update_attr(vc);
 
-	while (old_origin < scr_end) {
+	while (old_origin < vc->vc_scr_end) {
 		scr_memcpyw((unsigned short *) new_origin, (unsigned short *) old_origin, rlth);
 		if (rrem)
-			scr_memsetw((void *)(new_origin + rlth), video_erase_char, rrem);
+			scr_memsetw((void *)(new_origin + rlth), vc->vc_video_erase_char, rrem);
 		old_origin += old_row_size;
 		new_origin += new_row_size;
 	}
 	if (new_scr_end > new_origin)
-		scr_memsetw((void *) new_origin, video_erase_char, new_scr_end - new_origin);
-	if (kmalloced)
-		kfree(screenbuf);
-	screenbuf = newscreen;
-	kmalloced = 1;
-	screenbuf_size = new_screen_size;
+		scr_memsetw((void *)new_origin, vc->vc_video_erase_char, new_scr_end - new_origin);
+	if (vc->vc_kmalloced)
+		kfree(vc->vc_screenbuf);
+	vc->vc_screenbuf = newscreen;
+	vc->vc_kmalloced = 1;
+	vc->vc_screenbuf_size = new_screen_size;
 	set_origin(vc);
 
 	/* do part of a reset_terminal() */
-	top = 0;
-	bottom = vc->vc_rows;
-	gotoxy(vc, x, y);
+	vc->vc_top = 0;
+	vc->vc_bottom = vc->vc_rows;
+	gotoxy(vc, vc->vc_x, vc->vc_y);
 	save_cur(vc);
 
 	if (vc->vc_tty) {
@@ -835,7 +833,7 @@ int vc_resize(struct vc_data *vc, unsign
 		memset(&ws, 0, sizeof(ws));
 		ws.ws_row = vc->vc_rows;
 		ws.ws_col = vc->vc_cols;
-		ws.ws_ypixel = video_scan_lines;
+		ws.ws_ypixel = vc->vc_scan_lines;
 		if ((ws.ws_row != cws->ws_row || ws.ws_col != cws->ws_col) &&
 		    vc->vc_tty->pgrp > 0)
 			kill_pg(vc->vc_tty->pgrp, SIGWINCH, 1);
@@ -854,9 +852,9 @@ void vc_disallocate(unsigned int currcon
 
 	if (vc_cons_allocated(currcons)) {
 		struct vc_data *vc = vc_cons[currcons].d;
-		sw->con_deinit(vc);
-		if (kmalloced)
-			kfree(screenbuf);
+		vc->vc_sw->con_deinit(vc);
+		if (vc->vc_kmalloced)
+			kfree(vc->vc_screenbuf);
 		if (currcons >= MIN_NR_CONSOLES)
 			kfree(vc);
 		vc_cons[currcons].d = NULL;
@@ -931,7 +929,7 @@ static void gotoxy(struct vc_data *vc, i
 /* for absolute user moves, when decom is set */
 static void gotoxay(struct vc_data *vc, int new_x, int new_y)
 {
-	gotoxy(vc, new_x, decom ? (top+new_y) : new_y);
+	gotoxy(vc, new_x, vc->vc_decom ? (vc->vc_top + new_y) : new_y);
 }
 
 void scrollback(struct vc_data *vc, int lines)
@@ -953,13 +951,13 @@ static void lf(struct vc_data *vc)
     	/* don't scroll if above bottom of scrolling region, or
 	 * if below scrolling region
 	 */
-    	if (y+1 == bottom)
-		scrup(vc, top, bottom, 1);
-	else if (y < vc->vc_rows - 1) {
-	    	y++;
-		pos += vc->vc_size_row;
+    	if (vc->vc_y + 1 == vc->vc_bottom)
+		scrup(vc, vc->vc_top, vc->vc_bottom, 1);
+	else if (vc->vc_y < vc->vc_rows - 1) {
+	    	vc->vc_y++;
+		vc->vc_pos += vc->vc_size_row;
 	}
-	need_wrap = 0;
+	vc->vc_need_wrap = 0;
 }
 
 static void ri(struct vc_data *vc)
@@ -967,27 +965,27 @@ static void ri(struct vc_data *vc)
     	/* don't scroll if below top of scrolling region, or
 	 * if above scrolling region
 	 */
-	if (y == top)
-		scrdown(vc, top, bottom, 1);
-	else if (y > 0) {
-		y--;
-		pos -= vc->vc_size_row;
+	if (vc->vc_y == vc->vc_top)
+		scrdown(vc, vc->vc_top, vc->vc_bottom, 1);
+	else if (vc->vc_y > 0) {
+		vc->vc_y--;
+		vc->vc_pos -= vc->vc_size_row;
 	}
-	need_wrap = 0;
+	vc->vc_need_wrap = 0;
 }
 
 static inline void cr(struct vc_data *vc)
 {
-	pos -= x<<1;
-	need_wrap = x = 0;
+	vc->vc_pos -= vc->vc_x << 1;
+	vc->vc_need_wrap = vc->vc_x = 0;
 }
 
 static inline void bs(struct vc_data *vc)
 {
-	if (x) {
-		pos -= 2;
-		x--;
-		need_wrap = 0;
+	if (vc->vc_x) {
+		vc->vc_pos -= 2;
+		vc->vc_x--;
+		vc->vc_need_wrap = 0;
 	}
 }
 
@@ -1003,41 +1001,41 @@ static void csi_J(struct vc_data *vc, in
 
 	switch (vpar) {
 		case 0:	/* erase from cursor to end of display */
-			count = (scr_end-pos)>>1;
-			start = (unsigned short *) pos;
+			count = (vc->vc_scr_end - vc->vc_pos) >> 1;
+			start = (unsigned short *)vc->vc_pos;
 			if (DO_UPDATE(vc)) {
 				/* do in two stages */
-				sw->con_clear(vc, y, x, 1,
-					      vc->vc_cols - x);
-				sw->con_clear(vc, y + 1, 0,
-					      vc->vc_rows - y - 1,
+				vc->vc_sw->con_clear(vc, vc->vc_y, vc->vc_x, 1,
+					      vc->vc_cols - vc->vc_x);
+				vc->vc_sw->con_clear(vc, vc->vc_y + 1, 0,
+					      vc->vc_rows - vc->vc_y - 1,
 					      vc->vc_cols);
 			}
 			break;
 		case 1:	/* erase from start to cursor */
-			count = ((pos-origin)>>1)+1;
-			start = (unsigned short *) origin;
+			count = ((vc->vc_pos - vc->vc_origin) >> 1) + 1;
+			start = (unsigned short *)vc->vc_origin;
 			if (DO_UPDATE(vc)) {
 				/* do in two stages */
-				sw->con_clear(vc, 0, 0, y,
+				vc->vc_sw->con_clear(vc, 0, 0, vc->vc_y,
 					      vc->vc_cols);
-				sw->con_clear(vc, y, 0, 1,
-					      x + 1);
+				vc->vc_sw->con_clear(vc, vc->vc_y, 0, 1,
+					      vc->vc_x + 1);
 			}
 			break;
 		case 2: /* erase whole display */
 			count = vc->vc_cols * vc->vc_rows;
-			start = (unsigned short *) origin;
+			start = (unsigned short *)vc->vc_origin;
 			if (DO_UPDATE(vc))
-				sw->con_clear(vc, 0, 0,
+				vc->vc_sw->con_clear(vc, 0, 0,
 					      vc->vc_rows,
 					      vc->vc_cols);
 			break;
 		default:
 			return;
 	}
-	scr_memsetw(start, video_erase_char, 2*count);
-	need_wrap = 0;
+	scr_memsetw(start, vc->vc_video_erase_char, 2 * count);
+	vc->vc_need_wrap = 0;
 }
 
 static void csi_K(struct vc_data *vc, int vpar)
@@ -1047,31 +1045,31 @@ static void csi_K(struct vc_data *vc, in
 
 	switch (vpar) {
 		case 0:	/* erase from cursor to end of line */
-			count = vc->vc_cols - x;
-			start = (unsigned short *) pos;
+			count = vc->vc_cols - vc->vc_x;
+			start = (unsigned short *)vc->vc_pos;
 			if (DO_UPDATE(vc))
-				sw->con_clear(vc, y, x, 1,
-					      vc->vc_cols - x);
+				vc->vc_sw->con_clear(vc, vc->vc_y, vc->vc_x, 1,
+						     vc->vc_cols - vc->vc_x);
 			break;
 		case 1:	/* erase from start of line to cursor */
-			start = (unsigned short *) (pos - (x<<1));
-			count = x+1;
+			start = (unsigned short *)(vc->vc_pos - (vc->vc_x << 1));
+			count = vc->vc_x + 1;
 			if (DO_UPDATE(vc))
-				sw->con_clear(vc, y, 0, 1,
-					      x + 1);
+				vc->vc_sw->con_clear(vc, vc->vc_y, 0, 1,
+						     vc->vc_x + 1);
 			break;
 		case 2: /* erase whole line */
-			start = (unsigned short *) (pos - (x<<1));
+			start = (unsigned short *)(vc->vc_pos - (vc->vc_x << 1));
 			count = vc->vc_cols;
 			if (DO_UPDATE(vc))
-				sw->con_clear(vc, y, 0, 1,
+				vc->vc_sw->con_clear(vc, vc->vc_y, 0, 1,
 					      vc->vc_cols);
 			break;
 		default:
 			return;
 	}
-	scr_memsetw(start, video_erase_char, 2 * count);
-	need_wrap = 0;
+	scr_memsetw(start, vc->vc_video_erase_char, 2 * count);
+	vc->vc_need_wrap = 0;
 }
 
 static void csi_X(struct vc_data *vc, int vpar) /* erase the following vpar positions */
@@ -1080,21 +1078,21 @@ static void csi_X(struct vc_data *vc, in
 
 	if (!vpar)
 		vpar++;
-	count = (vpar > vc->vc_cols - x) ? (vc->vc_cols - x) : vpar;
+	count = (vpar > vc->vc_cols - vc->vc_x) ? (vc->vc_cols - vc->vc_x) : vpar;
 
-	scr_memsetw((unsigned short *) pos, video_erase_char, 2 * count);
+	scr_memsetw((unsigned short *)vc->vc_pos, vc->vc_video_erase_char, 2 * count);
 	if (DO_UPDATE(vc))
-		sw->con_clear(vc, y, x, 1, count);
-	need_wrap = 0;
+		vc->vc_sw->con_clear(vc, vc->vc_y, vc->vc_x, 1, count);
+	vc->vc_need_wrap = 0;
 }
 
 static void default_attr(struct vc_data *vc)
 {
-	intensity = 1;
-	underline = 0;
-	reverse = 0;
-	blink = 0;
-	color = def_color;
+	vc->vc_intensity = 1;
+	vc->vc_underline = 0;
+	vc->vc_reverse = 0;
+	vc->vc_blink = 0;
+	vc->vc_color = vc->vc_def_color;
 }
 
 /* console_sem is held */
@@ -1102,92 +1100,92 @@ static void csi_m(struct vc_data *vc)
 {
 	int i;
 
-	for (i=0;i<=npar;i++)
-		switch (par[i]) {
+	for (i = 0; i <= vc->vc_npar; i++)
+		switch (vc->vc_par[i]) {
 			case 0:	/* all attributes off */
 				default_attr(vc);
 				break;
 			case 1:
-				intensity = 2;
+				vc->vc_intensity = 2;
 				break;
 			case 2:
-				intensity = 0;
+				vc->vc_intensity = 0;
 				break;
 			case 4:
-				underline = 1;
+				vc->vc_underline = 1;
 				break;
 			case 5:
-				blink = 1;
+				vc->vc_blink = 1;
 				break;
 			case 7:
-				reverse = 1;
+				vc->vc_reverse = 1;
 				break;
 			case 10: /* ANSI X3.64-1979 (SCO-ish?)
 				  * Select primary font, don't display
 				  * control chars if defined, don't set
 				  * bit 8 on output.
 				  */
-				translate = set_translate(charset == 0
-						? G0_charset
-						: G1_charset, vc);
-				disp_ctrl = 0;
-				toggle_meta = 0;
+				vc->vc_translate = set_translate(vc->vc_charset == 0
+						? vc->vc_G0_charset
+						: vc->vc_G1_charset, vc);
+				vc->vc_disp_ctrl = 0;
+				vc->vc_toggle_meta = 0;
 				break;
 			case 11: /* ANSI X3.64-1979 (SCO-ish?)
 				  * Select first alternate font, lets
 				  * chars < 32 be displayed as ROM chars.
 				  */
-				translate = set_translate(IBMPC_MAP, vc);
-				disp_ctrl = 1;
-				toggle_meta = 0;
+				vc->vc_translate = set_translate(IBMPC_MAP, vc);
+				vc->vc_disp_ctrl = 1;
+				vc->vc_toggle_meta = 0;
 				break;
 			case 12: /* ANSI X3.64-1979 (SCO-ish?)
 				  * Select second alternate font, toggle
 				  * high bit before displaying as ROM char.
 				  */
-				translate = set_translate(IBMPC_MAP, vc);
-				disp_ctrl = 1;
-				toggle_meta = 1;
+				vc->vc_translate = set_translate(IBMPC_MAP, vc);
+				vc->vc_disp_ctrl = 1;
+				vc->vc_toggle_meta = 1;
 				break;
 			case 21:
 			case 22:
-				intensity = 1;
+				vc->vc_intensity = 1;
 				break;
 			case 24:
-				underline = 0;
+				vc->vc_underline = 0;
 				break;
 			case 25:
-				blink = 0;
+				vc->vc_blink = 0;
 				break;
 			case 27:
-				reverse = 0;
+				vc->vc_reverse = 0;
 				break;
 			case 38: /* ANSI X3.64-1979 (SCO-ish?)
 				  * Enables underscore, white foreground
 				  * with white underscore (Linux - use
 				  * default foreground).
 				  */
-				color = (def_color & 0x0f) | background;
-				underline = 1;
+				vc->vc_color = (vc->vc_def_color & 0x0f) | (vc->vc_color & 0xf0);
+				vc->vc_underline = 1;
 				break;
 			case 39: /* ANSI X3.64-1979 (SCO-ish?)
 				  * Disable underline option.
 				  * Reset colour to default? It did this
 				  * before...
 				  */
-				color = (def_color & 0x0f) | background;
-				underline = 0;
+				vc->vc_color = (vc->vc_def_color & 0x0f) | (vc->vc_color & 0xf0);
+				vc->vc_underline = 0;
 				break;
 			case 49:
-				color = (def_color & 0xf0) | foreground;
+				vc->vc_color = (vc->vc_def_color & 0xf0) | (vc->vc_color & 0x0f);
 				break;
 			default:
-				if (par[i] >= 30 && par[i] <= 37)
-					color = color_table[par[i]-30]
-						| background;
-				else if (par[i] >= 40 && par[i] <= 47)
-					color = (color_table[par[i]-40]<<4)
-						| foreground;
+				if (vc->vc_par[i] >= 30 && vc->vc_par[i] <= 37)
+					vc->vc_color = color_table[vc->vc_par[i] - 30]
+						| (vc->vc_color & 0xf0);
+				else if (vc->vc_par[i] >= 40 && vc->vc_par[i] <= 47)
+					vc->vc_color = (color_table[vc->vc_par[i] - 40] << 4)
+						| (vc->vc_color & 0x0f);
 				break;
 		}
 	update_attr(vc);
@@ -1206,7 +1204,7 @@ static void cursor_report(struct vc_data
 {
 	char buf[40];
 
-	sprintf(buf, "\033[%d;%dR", y + (decom ? top+1 : 1), x+1);
+	sprintf(buf, "\033[%d;%dR", vc->vc_y + (vc->vc_decom ? vc->vc_top + 1 : 1), vc->vc_x + 1);
 	respond_string(buf, tty);
 }
 
@@ -1232,9 +1230,7 @@ void mouse_report(struct tty_struct *tty
 /* invoked via ioctl(TIOCLINUX) and through set_selection */
 int mouse_reporting(void)
 {
-	struct vc_data *vc = vc_cons[fg_console].d;
-
-	return report_mouse;
+	return vc_cons[fg_console].d->vc_report_mouse;
 }
 
 /* console_sem is held */
@@ -1242,8 +1238,9 @@ static void set_mode(struct vc_data *vc,
 {
 	int i;
 
-	for (i=0; i<=npar; i++)
-		if (ques) switch(par[i]) {	/* DEC private modes set/reset */
+	for (i = 0; i <= vc->vc_npar; i++)
+		if (vc->vc_ques) {
+			switch(vc->vc_par[i]) {	/* DEC private modes set/reset */
 			case 1:			/* Cursor keys send ^[Ox/^[[x */
 				if (on_off)
 					set_kbd(vc, decckm);
@@ -1251,7 +1248,7 @@ static void set_mode(struct vc_data *vc,
 					clr_kbd(vc, decckm);
 				break;
 			case 3:	/* 80/132 mode switch unimplemented */
-				deccolm = on_off;
+				vc->vc_deccolm = on_off;
 #if 0
 				vc_resize(deccolm ? 132 : 80, vc->vc_rows);
 				/* this alone does not suffice; some user mode
@@ -1259,18 +1256,18 @@ static void set_mode(struct vc_data *vc,
 #endif
 				break;
 			case 5:			/* Inverted screen on/off */
-				if (decscnm != on_off) {
-					decscnm = on_off;
-					invert_screen(vc, 0, screenbuf_size, 0);
+				if (vc->vc_decscnm != on_off) {
+					vc->vc_decscnm = on_off;
+					invert_screen(vc, 0, vc->vc_screenbuf_size, 0);
 					update_attr(vc);
 				}
 				break;
 			case 6:			/* Origin relative/absolute */
-				decom = on_off;
+				vc->vc_decom = on_off;
 				gotoxay(vc, 0, 0);
 				break;
 			case 7:			/* Autowrap on/off */
-				decawm = on_off;
+				vc->vc_decawm = on_off;
 				break;
 			case 8:			/* Autorepeat on/off */
 				if (on_off)
@@ -1279,20 +1276,22 @@ static void set_mode(struct vc_data *vc,
 					clr_kbd(vc, decarm);
 				break;
 			case 9:
-				report_mouse = on_off ? 1 : 0;
+				vc->vc_report_mouse = on_off ? 1 : 0;
 				break;
 			case 25:		/* Cursor on/off */
-				deccm = on_off;
+				vc->vc_deccm = on_off;
 				break;
 			case 1000:
-				report_mouse = on_off ? 2 : 0;
+				vc->vc_report_mouse = on_off ? 2 : 0;
 				break;
-		} else switch(par[i]) {		/* ANSI modes set/reset */
+			}
+		} else {
+			switch(vc->vc_par[i]) {	/* ANSI modes set/reset */
 			case 3:			/* Monitor (display ctrls) */
-				disp_ctrl = on_off;
+				vc->vc_disp_ctrl = on_off;
 				break;
 			case 4:			/* Insert Mode on/off */
-				decim = on_off;
+				vc->vc_decim = on_off;
 				break;
 			case 20:		/* Lf, Enter == CrLf/Lf */
 				if (on_off)
@@ -1300,62 +1299,63 @@ static void set_mode(struct vc_data *vc,
 				else
 					clr_kbd(vc, lnm);
 				break;
+			}
 		}
 }
 
 /* console_sem is held */
 static void setterm_command(struct vc_data *vc)
 {
-	switch(par[0]) {
+	switch(vc->vc_par[0]) {
 		case 1:	/* set color for underline mode */
 			if (vc->vc_can_do_color &&
-					par[1] < 16) {
-				ulcolor = color_table[par[1]];
-				if (underline)
+					vc->vc_par[1] < 16) {
+				vc->vc_ulcolor = color_table[vc->vc_par[1]];
+				if (vc->vc_underline)
 					update_attr(vc);
 			}
 			break;
 		case 2:	/* set color for half intensity mode */
 			if (vc->vc_can_do_color &&
-					par[1] < 16) {
-				halfcolor = color_table[par[1]];
-				if (intensity == 0)
+					vc->vc_par[1] < 16) {
+				vc->vc_halfcolor = color_table[vc->vc_par[1]];
+				if (vc->vc_intensity == 0)
 					update_attr(vc);
 			}
 			break;
 		case 8:	/* store colors as defaults */
-			def_color = attr;
-			if (hi_font_mask == 0x100)
-				def_color >>= 1;
+			vc->vc_def_color = vc->vc_attr;
+			if (vc->vc_hi_font_mask == 0x100)
+				vc->vc_def_color >>= 1;
 			default_attr(vc);
 			update_attr(vc);
 			break;
 		case 9:	/* set blanking interval */
-			blankinterval = ((par[1] < 60) ? par[1] : 60) * 60 * HZ;
+			blankinterval = ((vc->vc_par[1] < 60) ? vc->vc_par[1] : 60) * 60 * HZ;
 			poke_blanked_console();
 			break;
 		case 10: /* set bell frequency in Hz */
-			if (npar >= 1)
-				bell_pitch = par[1];
+			if (vc->vc_npar >= 1)
+				vc->vc_bell_pitch = vc->vc_par[1];
 			else
-				bell_pitch = DEFAULT_BELL_PITCH;
+				vc->vc_bell_pitch = DEFAULT_BELL_PITCH;
 			break;
 		case 11: /* set bell duration in msec */
-			if (npar >= 1)
-				bell_duration = (par[1] < 2000) ?
-					par[1]*HZ/1000 : 0;
+			if (vc->vc_npar >= 1)
+				vc->vc_bell_duration = (vc->vc_par[1] < 2000) ?
+					vc->vc_par[1] * HZ / 1000 : 0;
 			else
-				bell_duration = DEFAULT_BELL_DURATION;
+				vc->vc_bell_duration = DEFAULT_BELL_DURATION;
 			break;
 		case 12: /* bring specified console to the front */
-			if (par[1] >= 1 && vc_cons_allocated(par[1]-1))
-				set_console(par[1] - 1);
+			if (vc->vc_par[1] >= 1 && vc_cons_allocated(vc->vc_par[1] - 1))
+				set_console(vc->vc_par[1] - 1);
 			break;
 		case 13: /* unblank the screen */
 			poke_blanked_console();
 			break;
 		case 14: /* set vesa powerdown interval */
-			vesa_off_interval = ((par[1] < 60) ? par[1] : 60) * 60 * HZ;
+			vesa_off_interval = ((vc->vc_par[1] < 60) ? vc->vc_par[1] : 60) * 60 * HZ;
 			break;
 		case 15: /* activate the previous console */
 			set_console(last_console);
@@ -1366,8 +1366,8 @@ static void setterm_command(struct vc_da
 /* console_sem is held */
 static void csi_at(struct vc_data *vc, unsigned int nr)
 {
-	if (nr > vc->vc_cols - x)
-		nr = vc->vc_cols - x;
+	if (nr > vc->vc_cols - vc->vc_x)
+		nr = vc->vc_cols - vc->vc_x;
 	else if (!nr)
 		nr = 1;
 	insert_char(vc, nr);
@@ -1376,19 +1376,19 @@ static void csi_at(struct vc_data *vc, u
 /* console_sem is held */
 static void csi_L(struct vc_data *vc, unsigned int nr)
 {
-	if (nr > vc->vc_rows - y)
-		nr = vc->vc_rows - y;
+	if (nr > vc->vc_rows - vc->vc_y)
+		nr = vc->vc_rows - vc->vc_y;
 	else if (!nr)
 		nr = 1;
-	scrdown(vc, y, bottom, nr);
-	need_wrap = 0;
+	scrdown(vc, vc->vc_y, vc->vc_bottom, nr);
+	vc->vc_need_wrap = 0;
 }
 
 /* console_sem is held */
 static void csi_P(struct vc_data *vc, unsigned int nr)
 {
-	if (nr > vc->vc_cols - x)
-		nr = vc->vc_cols - x;
+	if (nr > vc->vc_cols - vc->vc_x)
+		nr = vc->vc_cols - vc->vc_x;
 	else if (!nr)
 		nr = 1;
 	delete_char(vc, nr);
@@ -1397,44 +1397,44 @@ static void csi_P(struct vc_data *vc, un
 /* console_sem is held */
 static void csi_M(struct vc_data *vc, unsigned int nr)
 {
-	if (nr > vc->vc_rows - y)
-		nr = vc->vc_rows - y;
+	if (nr > vc->vc_rows - vc->vc_y)
+		nr = vc->vc_rows - vc->vc_y;
 	else if (!nr)
 		nr=1;
-	scrup(vc, y, bottom, nr);
-	need_wrap = 0;
+	scrup(vc, vc->vc_y, vc->vc_bottom, nr);
+	vc->vc_need_wrap = 0;
 }
 
 /* console_sem is held (except via vc_init->reset_terminal */
 static void save_cur(struct vc_data *vc)
 {
-	saved_x		= x;
-	saved_y		= y;
-	s_intensity	= intensity;
-	s_underline	= underline;
-	s_blink		= blink;
-	s_reverse	= reverse;
-	s_charset	= charset;
-	s_color		= color;
-	saved_G0	= G0_charset;
-	saved_G1	= G1_charset;
+	vc->vc_saved_x		= vc->vc_x;
+	vc->vc_saved_y		= vc->vc_y;
+	vc->vc_s_intensity	= vc->vc_intensity;
+	vc->vc_s_underline	= vc->vc_underline;
+	vc->vc_s_blink		= vc->vc_blink;
+	vc->vc_s_reverse	= vc->vc_reverse;
+	vc->vc_s_charset	= vc->vc_charset;
+	vc->vc_s_color		= vc->vc_color;
+	vc->vc_saved_G0		= vc->vc_G0_charset;
+	vc->vc_saved_G1		= vc->vc_G1_charset;
 }
 
 /* console_sem is held */
 static void restore_cur(struct vc_data *vc)
 {
-	gotoxy(vc, saved_x, saved_y);
-	intensity	= s_intensity;
-	underline	= s_underline;
-	blink		= s_blink;
-	reverse		= s_reverse;
-	charset		= s_charset;
-	color		= s_color;
-	G0_charset	= saved_G0;
-	G1_charset	= saved_G1;
-	translate	= set_translate(charset ? G1_charset : G0_charset, vc);
+	gotoxy(vc, vc->vc_saved_x, vc->vc_saved_y);
+	vc->vc_intensity	= vc->vc_s_intensity;
+	vc->vc_underline	= vc->vc_s_underline;
+	vc->vc_blink		= vc->vc_s_blink;
+	vc->vc_reverse		= vc->vc_s_reverse;
+	vc->vc_charset		= vc->vc_s_charset;
+	vc->vc_color		= vc->vc_s_color;
+	vc->vc_G0_charset	= vc->vc_saved_G0;
+	vc->vc_G1_charset	= vc->vc_saved_G1;
+	vc->vc_translate	= set_translate(vc->vc_charset ? vc->vc_G1_charset : vc->vc_G0_charset, vc);
 	update_attr(vc);
-	need_wrap = 0;
+	vc->vc_need_wrap = 0;
 }
 
 enum { ESnormal, ESesc, ESsquare, ESgetpars, ESgotpars, ESfunckey,
@@ -1444,27 +1444,27 @@ enum { ESnormal, ESesc, ESsquare, ESgetp
 /* console_sem is held (except via vc_init()) */
 static void reset_terminal(struct vc_data *vc, int do_clear)
 {
-	top		= 0;
-	bottom		= vc->vc_rows;
-	vc_state	= ESnormal;
-	ques		= 0;
-	translate	= set_translate(LAT1_MAP, vc);
-	G0_charset	= LAT1_MAP;
-	G1_charset	= GRAF_MAP;
-	charset		= 0;
-	need_wrap	= 0;
-	report_mouse	= 0;
-	utf             = 0;
-	utf_count       = 0;
-
-	disp_ctrl	= 0;
-	toggle_meta	= 0;
-
-	decscnm		= 0;
-	decom		= 0;
-	decawm		= 1;
-	deccm		= 1;
-	decim		= 0;
+	vc->vc_top		= 0;
+	vc->vc_bottom		= vc->vc_rows;
+	vc->vc_state		= ESnormal;
+	vc->vc_ques		= 0;
+	vc->vc_translate	= set_translate(LAT1_MAP, vc);
+	vc->vc_G0_charset	= LAT1_MAP;
+	vc->vc_G1_charset	= GRAF_MAP;
+	vc->vc_charset		= 0;
+	vc->vc_need_wrap	= 0;
+	vc->vc_report_mouse	= 0;
+	vc->vc_utf		= 0;
+	vc->vc_utf_count	= 0;
+
+	vc->vc_disp_ctrl	= 0;
+	vc->vc_toggle_meta	= 0;
+
+	vc->vc_decscnm		= 0;
+	vc->vc_decom		= 0;
+	vc->vc_decawm		= 1;
+	vc->vc_deccm		= 1;
+	vc->vc_decim		= 0;
 
 	set_kbd(vc, decarm);
 	clr_kbd(vc, decckm);
@@ -1477,20 +1477,20 @@ static void reset_terminal(struct vc_dat
 	/* do not do set_leds here because this causes an endless tasklet loop
 	   when the keyboard hasn't been initialized yet */
 
-	cursor_type = CUR_DEFAULT;
-	complement_mask = s_complement_mask;
+	vc->vc_cursor_type = CUR_DEFAULT;
+	vc->vc_complement_mask = vc->vc_s_complement_mask;
 
 	default_attr(vc);
 	update_attr(vc);
 
-	tab_stop[0]	= 0x01010100;
-	tab_stop[1]	=
-	tab_stop[2]	=
-	tab_stop[3]	=
-	tab_stop[4]	= 0x01010101;
+	vc->vc_tab_stop[0]	= 0x01010100;
+	vc->vc_tab_stop[1]	=
+	vc->vc_tab_stop[2]	=
+	vc->vc_tab_stop[3]	=
+	vc->vc_tab_stop[4]	= 0x01010101;
 
-	bell_pitch = DEFAULT_BELL_PITCH;
-	bell_duration = DEFAULT_BELL_DURATION;
+	vc->vc_bell_pitch = DEFAULT_BELL_PITCH;
+	vc->vc_bell_duration = DEFAULT_BELL_DURATION;
 
 	gotoxy(vc, 0, 0);
 	save_cur(vc);
@@ -1509,20 +1509,20 @@ static void do_con_trol(struct tty_struc
 	case 0:
 		return;
 	case 7:
-		if (bell_duration)
-			kd_mksound(bell_pitch, bell_duration);
+		if (vc->vc_bell_duration)
+			kd_mksound(vc->vc_bell_pitch, vc->vc_bell_duration);
 		return;
 	case 8:
 		bs(vc);
 		return;
 	case 9:
-		pos -= (x << 1);
-		while (x < vc->vc_cols - 1) {
-			x++;
-			if (tab_stop[x >> 5] & (1 << (x & 31)))
+		vc->vc_pos -= (vc->vc_x << 1);
+		while (vc->vc_x < vc->vc_cols - 1) {
+			vc->vc_x++;
+			if (vc->vc_tab_stop[vc->vc_x >> 5] & (1 << (vc->vc_x & 31)))
 				break;
 		}
-		pos += (x << 1);
+		vc->vc_pos += (vc->vc_x << 1);
 		return;
 	case 10: case 11: case 12:
 		lf(vc);
@@ -1532,40 +1532,40 @@ static void do_con_trol(struct tty_struc
 		cr(vc);
 		return;
 	case 14:
-		charset = 1;
-		translate = set_translate(G1_charset, vc);
-		disp_ctrl = 1;
+		vc->vc_charset = 1;
+		vc->vc_translate = set_translate(vc->vc_G1_charset, vc);
+		vc->vc_disp_ctrl = 1;
 		return;
 	case 15:
-		charset = 0;
-		translate = set_translate(G0_charset, vc);
-		disp_ctrl = 0;
+		vc->vc_charset = 0;
+		vc->vc_translate = set_translate(vc->vc_G0_charset, vc);
+		vc->vc_disp_ctrl = 0;
 		return;
 	case 24: case 26:
-		vc_state = ESnormal;
+		vc->vc_state = ESnormal;
 		return;
 	case 27:
-		vc_state = ESesc;
+		vc->vc_state = ESesc;
 		return;
 	case 127:
 		del(vc);
 		return;
 	case 128+27:
-		vc_state = ESsquare;
+		vc->vc_state = ESsquare;
 		return;
 	}
-	switch(vc_state) {
+	switch(vc->vc_state) {
 	case ESesc:
-		vc_state = ESnormal;
+		vc->vc_state = ESnormal;
 		switch (c) {
 		case '[':
-			vc_state = ESsquare;
+			vc->vc_state = ESsquare;
 			return;
 		case ']':
-			vc_state = ESnonstd;
+			vc->vc_state = ESnonstd;
 			return;
 		case '%':
-			vc_state = ESpercent;
+			vc->vc_state = ESpercent;
 			return;
 		case 'E':
 			cr(vc);
@@ -1578,7 +1578,7 @@ static void do_con_trol(struct tty_struc
 			lf(vc);
 			return;
 		case 'H':
-			tab_stop[x >> 5] |= (1 << (x & 31));
+			vc->vc_tab_stop[vc->vc_x >> 5] |= (1 << (vc->vc_x & 31));
 			return;
 		case 'Z':
 			respond_ID(tty);
@@ -1590,13 +1590,13 @@ static void do_con_trol(struct tty_struc
 			restore_cur(vc);
 			return;
 		case '(':
-			vc_state = ESsetG0;
+			vc->vc_state = ESsetG0;
 			return;
 		case ')':
-			vc_state = ESsetG1;
+			vc->vc_state = ESsetG1;
 			return;
 		case '#':
-			vc_state = EShash;
+			vc->vc_state = EShash;
 			return;
 		case 'c':
 			reset_terminal(vc, 1);
@@ -1611,57 +1611,58 @@ static void do_con_trol(struct tty_struc
 		return;
 	case ESnonstd:
 		if (c=='P') {   /* palette escape sequence */
-			for (npar=0; npar<NPAR; npar++)
-				par[npar] = 0 ;
-			npar = 0 ;
-			vc_state = ESpalette;
+			for (vc->vc_npar = 0; vc->vc_npar < NPAR; vc->vc_npar++)
+				vc->vc_par[vc->vc_npar] = 0;
+			vc->vc_npar = 0;
+			vc->vc_state = ESpalette;
 			return;
 		} else if (c=='R') {   /* reset palette */
 			reset_palette(vc);
-			vc_state = ESnormal;
+			vc->vc_state = ESnormal;
 		} else
-			vc_state = ESnormal;
+			vc->vc_state = ESnormal;
 		return;
 	case ESpalette:
 		if ( (c>='0'&&c<='9') || (c>='A'&&c<='F') || (c>='a'&&c<='f') ) {
-			par[npar++] = (c>'9' ? (c&0xDF)-'A'+10 : c-'0') ;
-			if (npar==7) {
-				int i = par[0]*3, j = 1;
-				palette[i] = 16*par[j++];
-				palette[i++] += par[j++];
-				palette[i] = 16*par[j++];
-				palette[i++] += par[j++];
-				palette[i] = 16*par[j++];
-				palette[i] += par[j];
+			vc->vc_par[vc->vc_npar++] = (c > '9' ? (c & 0xDF) - 'A' + 10 : c - '0');
+			if (vc->vc_npar == 7) {
+				int i = vc->vc_par[0] * 3, j = 1;
+				vc->vc_palette[i] = 16 * vc->vc_par[j++];
+				vc->vc_palette[i++] += vc->vc_par[j++];
+				vc->vc_palette[i] = 16 * vc->vc_par[j++];
+				vc->vc_palette[i++] += vc->vc_par[j++];
+				vc->vc_palette[i] = 16 * vc->vc_par[j++];
+				vc->vc_palette[i] += vc->vc_par[j];
 				set_palette(vc);
-				vc_state = ESnormal;
+				vc->vc_state = ESnormal;
 			}
 		} else
-			vc_state = ESnormal;
+			vc->vc_state = ESnormal;
 		return;
 	case ESsquare:
-		for(npar = 0 ; npar < NPAR ; npar++)
-			par[npar] = 0;
-		npar = 0;
-		vc_state = ESgetpars;
+		for (vc->vc_npar = 0; vc->vc_npar < NPAR; vc->vc_npar++)
+			vc->vc_par[vc->vc_npar] = 0;
+		vc->vc_npar = 0;
+		vc->vc_state = ESgetpars;
 		if (c == '[') { /* Function key */
-			vc_state=ESfunckey;
+			vc->vc_state=ESfunckey;
 			return;
 		}
-		ques = (c=='?');
-		if (ques)
+		vc->vc_ques = (c == '?');
+		if (vc->vc_ques)
 			return;
 	case ESgetpars:
-		if (c==';' && npar<NPAR-1) {
-			npar++;
+		if (c == ';' && vc->vc_npar < NPAR - 1) {
+			vc->vc_npar++;
 			return;
 		} else if (c>='0' && c<='9') {
-			par[npar] *= 10;
-			par[npar] += c-'0';
+			vc->vc_par[vc->vc_npar] *= 10;
+			vc->vc_par[vc->vc_npar] += c - '0';
 			return;
-		} else vc_state=ESgotpars;
+		} else
+			vc->vc_state = ESgotpars;
 	case ESgotpars:
-		vc_state = ESnormal;
+		vc->vc_state = ESnormal;
 		switch(c) {
 		case 'h':
 			set_mode(vc, 1);
@@ -1670,103 +1671,113 @@ static void do_con_trol(struct tty_struc
 			set_mode(vc, 0);
 			return;
 		case 'c':
-			if (ques) {
-				if (par[0])
-					cursor_type = par[0] | (par[1]<<8) | (par[2]<<16);
+			if (vc->vc_ques) {
+				if (vc->vc_par[0])
+					vc->vc_cursor_type = vc->vc_par[0] | (vc->vc_par[1] << 8) | (vc->vc_par[2] << 16);
 				else
-					cursor_type = CUR_DEFAULT;
+					vc->vc_cursor_type = CUR_DEFAULT;
 				return;
 			}
 			break;
 		case 'm':
-			if (ques) {
+			if (vc->vc_ques) {
 				clear_selection();
-				if (par[0])
-					complement_mask = par[0]<<8 | par[1];
+				if (vc->vc_par[0])
+					vc->vc_complement_mask = vc->vc_par[0] << 8 | vc->vc_par[1];
 				else
-					complement_mask = s_complement_mask;
+					vc->vc_complement_mask = vc->vc_s_complement_mask;
 				return;
 			}
 			break;
 		case 'n':
-			if (!ques) {
-				if (par[0] == 5)
+			if (!vc->vc_ques) {
+				if (vc->vc_par[0] == 5)
 					status_report(tty);
-				else if (par[0] == 6)
+				else if (vc->vc_par[0] == 6)
 					cursor_report(vc, tty);
 			}
 			return;
 		}
-		if (ques) {
-			ques = 0;
+		if (vc->vc_ques) {
+			vc->vc_ques = 0;
 			return;
 		}
 		switch(c) {
 		case 'G': case '`':
-			if (par[0]) par[0]--;
-			gotoxy(vc, par[0], y);
+			if (vc->vc_par[0])
+				vc->vc_par[0]--;
+			gotoxy(vc, vc->vc_par[0], vc->vc_y);
 			return;
 		case 'A':
-			if (!par[0]) par[0]++;
-			gotoxy(vc, x, y - par[0]);
+			if (!vc->vc_par[0])
+				vc->vc_par[0]++;
+			gotoxy(vc, vc->vc_x, vc->vc_y - vc->vc_par[0]);
 			return;
 		case 'B': case 'e':
-			if (!par[0]) par[0]++;
-			gotoxy(vc, x, y + par[0]);
+			if (!vc->vc_par[0])
+				vc->vc_par[0]++;
+			gotoxy(vc, vc->vc_x, vc->vc_y + vc->vc_par[0]);
 			return;
 		case 'C': case 'a':
-			if (!par[0]) par[0]++;
-			gotoxy(vc, x + par[0], y);
+			if (!vc->vc_par[0])
+				vc->vc_par[0]++;
+			gotoxy(vc, vc->vc_x + vc->vc_par[0], vc->vc_y);
 			return;
 		case 'D':
-			if (!par[0]) par[0]++;
-			gotoxy(vc, x - par[0], y);
+			if (!vc->vc_par[0])
+				vc->vc_par[0]++;
+			gotoxy(vc, vc->vc_x - vc->vc_par[0], vc->vc_y);
 			return;
 		case 'E':
-			if (!par[0]) par[0]++;
-			gotoxy(vc, 0, y + par[0]);
+			if (!vc->vc_par[0])
+				vc->vc_par[0]++;
+			gotoxy(vc, 0, vc->vc_y + vc->vc_par[0]);
 			return;
 		case 'F':
-			if (!par[0]) par[0]++;
-			gotoxy(vc, 0, y - par[0]);
+			if (!vc->vc_par[0])
+				vc->vc_par[0]++;
+			gotoxy(vc, 0, vc->vc_y - vc->vc_par[0]);
 			return;
 		case 'd':
-			if (par[0]) par[0]--;
-			gotoxay(vc, x, par[0]);
+			if (vc->vc_par[0])
+				vc->vc_par[0]--;
+			gotoxay(vc, vc->vc_x ,vc->vc_par[0]);
 			return;
 		case 'H': case 'f':
-			if (par[0]) par[0]--;
-			if (par[1]) par[1]--;
-			gotoxay(vc, par[1], par[0]);
+			if (vc->vc_par[0])
+				vc->vc_par[0]--;
+			if (vc->vc_par[1])
+				vc->vc_par[1]--;
+			gotoxay(vc, vc->vc_par[1], vc->vc_par[0]);
 			return;
 		case 'J':
-			csi_J(vc, par[0]);
+			csi_J(vc, vc->vc_par[0]);
 			return;
 		case 'K':
-			csi_K(vc, par[0]);
+			csi_K(vc, vc->vc_par[0]);
 			return;
 		case 'L':
-			csi_L(vc, par[0]);
+			csi_L(vc, vc->vc_par[0]);
 			return;
 		case 'M':
-			csi_M(vc, par[0]);
+			csi_M(vc, vc->vc_par[0]);
 			return;
 		case 'P':
-			csi_P(vc, par[0]);
+			csi_P(vc, vc->vc_par[0]);
 			return;
 		case 'c':
-			if (!par[0])
+			if (!vc->vc_par[0])
 				respond_ID(tty);
 			return;
 		case 'g':
-			if (!par[0])
-				tab_stop[x >> 5] &= ~(1 << (x & 31));
-			else if (par[0] == 3) {
-				tab_stop[0] =
-					tab_stop[1] =
-					tab_stop[2] =
-					tab_stop[3] =
-					tab_stop[4] = 0;
+			if (!vc->vc_par[0])
+				vc->vc_tab_stop[vc->vc_x >> 5] &= ~(1 << (vc->vc_x & 31));
+			else if (vc->vc_par[0] == 3) {
+				vc->vc_tab_stop[0] =
+					vc->vc_tab_stop[1] =
+					vc->vc_tab_stop[2] =
+					vc->vc_tab_stop[3] =
+					vc->vc_tab_stop[4] = 0;
 			}
 			return;
 		case 'm':
@@ -1774,20 +1785,20 @@ static void do_con_trol(struct tty_struc
 			return;
 		case 'q': /* DECLL - but only 3 leds */
 			/* map 0,1,2,3 to 0,1,2,4 */
-			if (par[0] < 4)
+			if (vc->vc_par[0] < 4)
 				setledstate(kbd_table + vc->vc_num,
-					    (par[0] < 3) ? par[0] : 4);
+					    (vc->vc_par[0] < 3) ? vc->vc_par[0] : 4);
 			return;
 		case 'r':
-			if (!par[0])
-				par[0]++;
-			if (!par[1])
-				par[1] = vc->vc_rows;
+			if (!vc->vc_par[0])
+				vc->vc_par[0]++;
+			if (!vc->vc_par[1])
+				vc->vc_par[1] = vc->vc_rows;
 			/* Minimum allowed region is 2 lines */
-			if (par[0] < par[1] &&
-			    par[1] <= vc->vc_rows) {
-				top=par[0]-1;
-				bottom=par[1];
+			if (vc->vc_par[0] < vc->vc_par[1] &&
+			    vc->vc_par[1] <= vc->vc_rows) {
+				vc->vc_top = vc->vc_par[0] - 1;
+				vc->vc_bottom = vc->vc_par[1];
 				gotoxay(vc, 0, 0);
 			}
 			return;
@@ -1798,10 +1809,10 @@ static void do_con_trol(struct tty_struc
 			restore_cur(vc);
 			return;
 		case 'X':
-			csi_X(vc, par[0]);
+			csi_X(vc, vc->vc_par[0]);
 			return;
 		case '@':
-			csi_at(vc, par[0]);
+			csi_at(vc, vc->vc_par[0]);
 			return;
 		case ']': /* setterm functions */
 			setterm_command(vc);
@@ -1809,60 +1820,60 @@ static void do_con_trol(struct tty_struc
 		}
 		return;
 	case ESpercent:
-		vc_state = ESnormal;
+		vc->vc_state = ESnormal;
 		switch (c) {
 		case '@':  /* defined in ISO 2022 */
-			utf = 0;
+			vc->vc_utf = 0;
 			return;
 		case 'G':  /* prelim official escape code */
 		case '8':  /* retained for compatibility */
-			utf = 1;
+			vc->vc_utf = 1;
 			return;
 		}
 		return;
 	case ESfunckey:
-		vc_state = ESnormal;
+		vc->vc_state = ESnormal;
 		return;
 	case EShash:
-		vc_state = ESnormal;
+		vc->vc_state = ESnormal;
 		if (c == '8') {
 			/* DEC screen alignment test. kludge :-) */
-			video_erase_char =
-				(video_erase_char & 0xff00) | 'E';
+			vc->vc_video_erase_char =
+				(vc->vc_video_erase_char & 0xff00) | 'E';
 			csi_J(vc, 2);
-			video_erase_char =
-				(video_erase_char & 0xff00) | ' ';
-			do_update_region(vc, origin, screenbuf_size / 2);
+			vc->vc_video_erase_char =
+				(vc->vc_video_erase_char & 0xff00) | ' ';
+			do_update_region(vc, vc->vc_origin, vc->vc_screenbuf_size / 2);
 		}
 		return;
 	case ESsetG0:
 		if (c == '0')
-			G0_charset = GRAF_MAP;
+			vc->vc_G0_charset = GRAF_MAP;
 		else if (c == 'B')
-			G0_charset = LAT1_MAP;
+			vc->vc_G0_charset = LAT1_MAP;
 		else if (c == 'U')
-			G0_charset = IBMPC_MAP;
+			vc->vc_G0_charset = IBMPC_MAP;
 		else if (c == 'K')
-			G0_charset = USER_MAP;
-		if (charset == 0)
-			translate = set_translate(G0_charset, vc);
-		vc_state = ESnormal;
+			vc->vc_G0_charset = USER_MAP;
+		if (vc->vc_charset == 0)
+			vc->vc_translate = set_translate(vc->vc_G0_charset, vc);
+		vc->vc_state = ESnormal;
 		return;
 	case ESsetG1:
 		if (c == '0')
-			G1_charset = GRAF_MAP;
+			vc->vc_G1_charset = GRAF_MAP;
 		else if (c == 'B')
-			G1_charset = LAT1_MAP;
+			vc->vc_G1_charset = LAT1_MAP;
 		else if (c == 'U')
-			G1_charset = IBMPC_MAP;
+			vc->vc_G1_charset = IBMPC_MAP;
 		else if (c == 'K')
-			G1_charset = USER_MAP;
-		if (charset == 1)
-			translate = set_translate(G1_charset, vc);
-		vc_state = ESnormal;
+			vc->vc_G1_charset = USER_MAP;
+		if (vc->vc_charset == 1)
+			vc->vc_translate = set_translate(vc->vc_G1_charset, vc);
+		vc->vc_state = ESnormal;
 		return;
 	default:
-		vc_state = ESnormal;
+		vc->vc_state = ESnormal;
 	}
 }
 
@@ -1885,7 +1896,7 @@ static int do_con_write(struct tty_struc
 #define FLUSH do { } while(0);
 #else
 #define FLUSH if (draw_x >= 0) { \
-	sw->con_putcs(vc, (u16 *)draw_from, (u16 *)draw_to-(u16 *)draw_from, y, draw_x); \
+	vc->vc_sw->con_putcs(vc, (u16 *)draw_from, (u16 *)draw_to - (u16 *)draw_from, vc->vc_y, draw_x); \
 	draw_x = -1; \
 	}
 #endif
@@ -1945,7 +1956,7 @@ static int do_con_write(struct tty_struc
 		goto out;
 	}
 
-	himask = hi_font_mask;
+	himask = vc->vc_hi_font_mask;
 	charmask = himask ? 0x1ff : 0xff;
 
 	/* undraw cursor first */
@@ -1960,44 +1971,44 @@ static int do_con_write(struct tty_struc
 		count--;
 
 		/* Do no translation at all in control states */
-		if (vc_state != ESnormal) {
+		if (vc->vc_state != ESnormal) {
 			tc = c;
-		} else if (utf) {
+		} else if (vc->vc_utf) {
 		    /* Combine UTF-8 into Unicode */
 		    /* Incomplete characters silently ignored */
 		    if(c > 0x7f) {
-			if (utf_count > 0 && (c & 0xc0) == 0x80) {
-				utf_char = (utf_char << 6) | (c & 0x3f);
-				utf_count--;
-				if (utf_count == 0)
-				    tc = c = utf_char;
+			if (vc->vc_utf_count > 0 && (c & 0xc0) == 0x80) {
+				vc->vc_utf_char = (vc->vc_utf_char << 6) | (c & 0x3f);
+				vc->vc_utf_count--;
+				if (vc->vc_utf_count == 0)
+				    tc = c = vc->vc_utf_char;
 				else continue;
 			} else {
 				if ((c & 0xe0) == 0xc0) {
-				    utf_count = 1;
-				    utf_char = (c & 0x1f);
+				    vc->vc_utf_count = 1;
+				    vc->vc_utf_char = (c & 0x1f);
 				} else if ((c & 0xf0) == 0xe0) {
-				    utf_count = 2;
-				    utf_char = (c & 0x0f);
+				    vc->vc_utf_count = 2;
+				    vc->vc_utf_char = (c & 0x0f);
 				} else if ((c & 0xf8) == 0xf0) {
-				    utf_count = 3;
-				    utf_char = (c & 0x07);
+				    vc->vc_utf_count = 3;
+				    vc->vc_utf_char = (c & 0x07);
 				} else if ((c & 0xfc) == 0xf8) {
-				    utf_count = 4;
-				    utf_char = (c & 0x03);
+				    vc->vc_utf_count = 4;
+				    vc->vc_utf_char = (c & 0x03);
 				} else if ((c & 0xfe) == 0xfc) {
-				    utf_count = 5;
-				    utf_char = (c & 0x01);
+				    vc->vc_utf_count = 5;
+				    vc->vc_utf_char = (c & 0x01);
 				} else
-				    utf_count = 0;
+				    vc->vc_utf_count = 0;
 				continue;
 			      }
 		    } else {
 		      tc = c;
-		      utf_count = 0;
+		      vc->vc_utf_count = 0;
 		    }
 		} else {	/* no utf */
-		  tc = translate[toggle_meta ? (c|0x80) : c];
+		  tc = vc->vc_translate[vc->vc_toggle_meta ? (c | 0x80) : c];
 		}
 
                 /* If the original code was a control character we
@@ -2011,12 +2022,12 @@ static int do_con_write(struct tty_struc
                  * direct-to-font zone in UTF-8 mode.
                  */
                 ok = tc && (c >= 32 ||
-                            (!utf && !(((disp_ctrl ? CTRL_ALWAYS
-                                         : CTRL_ACTION) >> c) & 1)))
-                        && (c != 127 || disp_ctrl)
+			    (!vc->vc_utf && !(((vc->vc_disp_ctrl ? CTRL_ALWAYS
+						: CTRL_ACTION) >> c) & 1)))
+			&& (c != 127 || vc->vc_disp_ctrl)
 			&& (c != 128+27);
 
-		if (vc_state == ESnormal && ok) {
+		if (vc->vc_state == ESnormal && ok) {
 			/* Now try to find out how to display it */
 			tc = conv_uni_to_pc(vc, tc);
 			if ( tc == -4 ) {
@@ -2036,28 +2047,28 @@ static int do_con_write(struct tty_struc
 			if (tc & ~charmask)
                                 continue; /* Conversion failed */
 
-			if (need_wrap || decim)
+			if (vc->vc_need_wrap || vc->vc_decim)
 				FLUSH
-			if (need_wrap) {
+			if (vc->vc_need_wrap) {
 				cr(vc);
 				lf(vc);
 			}
-			if (decim)
+			if (vc->vc_decim)
 				insert_char(vc, 1);
 			scr_writew(himask ?
-				     ((attr << 8) & ~himask) + ((tc & 0x100) ? himask : 0) + (tc & 0xff) :
-				     (attr << 8) + tc,
-				   (u16 *) pos);
+				     ((vc->vc_attr << 8) & ~himask) + ((tc & 0x100) ? himask : 0) + (tc & 0xff) :
+				     (vc->vc_attr << 8) + tc,
+				   (u16 *) vc->vc_pos);
 			if (DO_UPDATE(vc) && draw_x < 0) {
-				draw_x = x;
-				draw_from = pos;
+				draw_x = vc->vc_x;
+				draw_from = vc->vc_pos;
 			}
-			if (x == vc->vc_cols - 1) {
-				need_wrap = decawm;
-				draw_to = pos+2;
+			if (vc->vc_x == vc->vc_cols - 1) {
+				vc->vc_need_wrap = vc->vc_decawm;
+				draw_to = vc->vc_pos + 2;
 			} else {
-				x++;
-				draw_to = (pos+=2);
+				vc->vc_x++;
+				draw_to = (vc->vc_pos += 2);
 			}
 			continue;
 		}
@@ -2104,8 +2115,8 @@ static void console_callback(void *ignor
 	if (scrollback_delta) {
 		struct vc_data *vc = vc_cons[fg_console].d;
 		clear_selection();
-		if (vcmode == KD_TEXT)
-			sw->con_scrolldelta(vc, scrollback_delta);
+		if (vt_cons[vc->vc_num]->vc_mode == KD_TEXT)
+			vc->vc_sw->con_scrolldelta(vc, scrollback_delta);
 		scrollback_delta = 0;
 	}
 	if (blank_timer_expired) {
@@ -2150,7 +2161,7 @@ void vt_console_print(struct console *co
 
 	/* read `x' only after setting currcons properly (otherwise
 	   the `x' macro will read the x of the foreground console). */
-	myx = x;
+	myx = vc->vc_x;
 
 	if (!vc_cons_allocated(fg_console)) {
 		/* impossible */
@@ -2158,58 +2169,58 @@ void vt_console_print(struct console *co
 		goto quit;
 	}
 
-	if (vcmode != KD_TEXT)
+	if (vt_cons[vc->vc_num]->vc_mode != KD_TEXT)
 		goto quit;
 
 	/* undraw cursor first */
 	if (vc->vc_num == fg_console)
 		hide_cursor(vc);
 
-	start = (ushort *)pos;
+	start = (ushort *)vc->vc_pos;
 
 	/* Contrived structure to try to emulate original need_wrap behaviour
 	 * Problems caused when we have need_wrap set on '\n' character */
 	while (count--) {
 		c = *b++;
-		if (c == 10 || c == 13 || c == 8 || need_wrap) {
+		if (c == 10 || c == 13 || c == 8 || vc->vc_need_wrap) {
 			if (cnt > 0) {
 				if (CON_IS_VISIBLE(vc))
-					sw->con_putcs(vc, start, cnt, y, x);
-				x += cnt;
-				if (need_wrap)
-					x--;
+					vc->vc_sw->con_putcs(vc, start, cnt, vc->vc_y, vc->vc_x);
+				vc->vc_x += cnt;
+				if (vc->vc_need_wrap)
+					vc->vc_x--;
 				cnt = 0;
 			}
 			if (c == 8) {		/* backspace */
 				bs(vc);
-				start = (ushort *)pos;
-				myx = x;
+				start = (ushort *)vc->vc_pos;
+				myx = vc->vc_x;
 				continue;
 			}
 			if (c != 13)
 				lf(vc);
 			cr(vc);
-			start = (ushort *)pos;
-			myx = x;
+			start = (ushort *)vc->vc_pos;
+			myx = vc->vc_x;
 			if (c == 10 || c == 13)
 				continue;
 		}
-		scr_writew((attr << 8) + c, (unsigned short *) pos);
+		scr_writew((vc->vc_attr << 8) + c, (unsigned short *)vc->vc_pos);
 		cnt++;
 		if (myx == vc->vc_cols - 1) {
-			need_wrap = 1;
+			vc->vc_need_wrap = 1;
 			continue;
 		}
-		pos+=2;
+		vc->vc_pos += 2;
 		myx++;
 	}
 	if (cnt > 0) {
 		if (CON_IS_VISIBLE(vc))
-			sw->con_putcs(vc, start, cnt, y, x);
-		x += cnt;
-		if (x == vc->vc_cols) {
-			x--;
-			need_wrap = 1;
+			vc->vc_sw->con_putcs(vc, start, cnt, vc->vc_y, vc->vc_x);
+		vc->vc_x += cnt;
+		if (vc->vc_x == vc->vc_cols) {
+			vc->vc_x--;
+			vc->vc_need_wrap = 1;
 		}
 	}
 	set_cursor(vc);
@@ -2498,19 +2509,19 @@ static void vc_init(struct vc_data *vc, 
 	vc->vc_cols = cols;
 	vc->vc_rows = rows;
 	vc->vc_size_row = cols << 1;
-	screenbuf_size = vc->vc_rows * vc->vc_size_row;
+	vc->vc_screenbuf_size = vc->vc_rows * vc->vc_size_row;
 
 	set_origin(vc);
-	pos = origin;
+	vc->vc_pos = vc->vc_origin;
 	reset_vc(vc);
 	for (j=k=0; j<16; j++) {
 		vc->vc_palette[k++] = default_red[j] ;
 		vc->vc_palette[k++] = default_grn[j] ;
 		vc->vc_palette[k++] = default_blu[j] ;
 	}
-	def_color       = 0x07;   /* white */
-	ulcolor		= 0x0f;   /* bold white */
-	halfcolor       = 0x08;   /* grey */
+	vc->vc_def_color       = 0x07;   /* white */
+	vc->vc_ulcolor		= 0x0f;   /* bold white */
+	vc->vc_halfcolor       = 0x08;   /* grey */
 	init_waitqueue_head(&vt_cons[vc->vc_num]->paste_wait);
 	reset_terminal(vc, do_clear);
 }
@@ -2554,16 +2565,16 @@ static int __init con_init(void)
 				alloc_bootmem(sizeof(struct vt_struct));
 		vc_cons[currcons].d->vc_vt = vt_cons[currcons];
 		visual_init(vc, currcons, 1);
-		screenbuf = (unsigned short *) alloc_bootmem(screenbuf_size);
-		kmalloced = 0;
+		vc->vc_screenbuf = (unsigned short *)alloc_bootmem(vc->vc_screenbuf_size);
+		vc->vc_kmalloced = 0;
 		vc_init(vc, vc->vc_rows, vc->vc_cols,
-			currcons || !sw->con_save_screen);
+			currcons || !vc->vc_sw->con_save_screen);
 	}
 	currcons = fg_console = 0;
 	master_display_fg = vc = vc_cons[currcons].d;
 	set_origin(vc);
 	save_screen(vc);
-	gotoxy(vc, x, y);
+	gotoxy(vc, vc->vc_x, vc->vc_y);
 	csi_J(vc, 0);
 	update_screen(vc);
 	printk("Console: %s %s %dx%d",
@@ -2677,10 +2688,10 @@ int take_over_console(const struct consw
 			save_screen(vc);
 		old_was_color = vc->vc_can_do_color;
 		vc->vc_sw->con_deinit(vc);
-		origin = (unsigned long) screenbuf;
-		visible_origin = origin;
-		scr_end = origin + screenbuf_size;
-		pos = origin + vc->vc_size_row * y + 2 * x;
+		vc->vc_origin = (unsigned long)vc->vc_screenbuf;
+		vc->vc_visible_origin = vc->vc_origin;
+		vc->vc_scr_end = vc->vc_origin + vc->vc_screenbuf_size;
+		vc->vc_pos = vc->vc_origin + vc->vc_size_row * vc->vc_y + 2 * vc->vc_x;
 		visual_init(vc, i, 0);
 		update_attr(vc);
 
@@ -2780,14 +2791,14 @@ void do_blank_screen(int entering_gfx)
 	if (entering_gfx) {
 		hide_cursor(vc);
 		save_screen(vc);
-		sw->con_blank(vc, -1, 1);
+		vc->vc_sw->con_blank(vc, -1, 1);
 		console_blanked = fg_console + 1;
 		set_origin(vc);
 		return;
 	}
 
 	/* don't blank graphics */
-	if (vcmode != KD_TEXT) {
+	if (vt_cons[vc->vc_num]->vc_mode != KD_TEXT) {
 		console_blanked = fg_console + 1;
 		return;
 	}
@@ -2798,7 +2809,7 @@ void do_blank_screen(int entering_gfx)
 
 	save_screen(vc);
 	/* In case we need to reset origin, blanking hook returns 1 */
-	i = sw->con_blank(vc, 1, 0);
+	i = vc->vc_sw->con_blank(vc, 1, 0);
 	console_blanked = fg_console + 1;
 	if (i)
 		set_origin(vc);
@@ -2812,7 +2823,7 @@ void do_blank_screen(int entering_gfx)
 	}
 
     	if (vesa_blank_mode)
-		sw->con_blank(vc, vesa_blank_mode + 1, 0);
+		vc->vc_sw->con_blank(vc, vesa_blank_mode + 1, 0);
 }
 EXPORT_SYMBOL(do_blank_screen);
 
@@ -2834,7 +2845,7 @@ void do_unblank_screen(int leaving_gfx)
 		return;
 	}
 	vc = vc_cons[fg_console].d;
-	if (vcmode != KD_TEXT)
+	if (vt_cons[vc->vc_num]->vc_mode != KD_TEXT)
 		return; /* but leave console_blanked != 0 */
 
 	if (blankinterval) {
@@ -2843,7 +2854,7 @@ void do_unblank_screen(int leaving_gfx)
 	}
 
 	console_blanked = 0;
-	if (sw->con_blank(vc, 0, leaving_gfx))
+	if (vc->vc_sw->con_blank(vc, 0, leaving_gfx))
 		/* Low-level driver cannot restore -> do it ourselves */
 		update_screen(vc);
 	if (console_blank_hook)
@@ -2903,8 +2914,8 @@ void set_palette(struct vc_data *vc)
 {
 	WARN_CONSOLE_UNLOCKED();
 
-	if (vcmode != KD_GRAPHICS)
-		sw->con_set_palette(vc, color_table);
+	if (vt_cons[vc->vc_num]->vc_mode != KD_GRAPHICS)
+		vc->vc_sw->con_set_palette(vc, color_table);
 }
 
 static int set_get_cmap(unsigned char __user *arg, int set)
@@ -2968,9 +2979,9 @@ void reset_palette(struct vc_data *vc)
 {
 	int j, k;
 	for (j=k=0; j<16; j++) {
-		palette[k++] = default_red[j];
-		palette[k++] = default_grn[j];
-		palette[k++] = default_blu[j];
+		vc->vc_palette[k++] = default_red[j];
+		vc->vc_palette[k++] = default_grn[j];
+		vc->vc_palette[k++] = default_blu[j];
 	}
 	set_palette(vc);
 }
@@ -3007,8 +3018,8 @@ int con_font_get(struct vc_data *vc, str
 		font.data = NULL;
 
 	acquire_console_sem();
-	if (sw->con_font_get)
-		rc = sw->con_font_get(vc, &font);
+	if (vc->vc_sw->con_font_get)
+		rc = vc->vc_sw->con_font_get(vc, &font);
 	else
 		rc = -ENOSYS;
 	release_console_sem();
@@ -3093,8 +3104,8 @@ int con_font_set(struct vc_data *vc, str
 		return -EFAULT;
 	}
 	acquire_console_sem();
-	if (sw->con_font_set)
-		rc = sw->con_font_set(vc, &font, op->flags);
+	if (vc->vc_sw->con_font_set)
+		rc = vc->vc_sw->con_font_set(vc, &font, op->flags);
 	else
 		rc = -ENOSYS;
 	release_console_sem();
@@ -3120,8 +3131,8 @@ int con_font_default(struct vc_data *vc,
 		name[MAX_FONT_NAME - 1] = 0;
 
 	acquire_console_sem();
-	if (sw->con_font_default)
-		rc = sw->con_font_default(vc, &font, s);
+	if (vc->vc_sw->con_font_default)
+		rc = vc->vc_sw->con_font_default(vc, &font, s);
 	else
 		rc = -ENOSYS;
 	release_console_sem();
@@ -3141,14 +3152,14 @@ int con_font_copy(struct vc_data *vc, st
 		return -EINVAL;
 
 	acquire_console_sem();
-	if (!sw->con_font_copy)
+	if (!vc->vc_sw->con_font_copy)
 		rc = -ENOSYS;
 	else if (con < 0 || !vc_cons_allocated(con))
 		rc = -ENOTTY;
 	else if (con == vc->vc_num)	/* nothing to do */
 		rc = 0;
 	else
-		rc = sw->con_font_copy(vc, con);
+		rc = vc->vc_sw->con_font_copy(vc, con);
 	release_console_sem();
 	return rc;
 }
