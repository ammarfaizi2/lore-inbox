Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265707AbTL3KFR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 05:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265709AbTL3KFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 05:05:17 -0500
Received: from math.ut.ee ([193.40.5.125]:63222 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S265707AbTL3KEe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 05:04:34 -0500
Date: Tue, 30 Dec 2003 12:04:31 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0+BK keyboard problems
Message-ID: <Pine.GSO.4.44.0312301157210.23594-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I compiled todays 2.6.0-BK and tried it on my PC with Estonian layout
PS/2 keyboard (Keytronic KT800PS2ES03). I has one problem with
loadkeys and some strange messages when X starts.

The problem comes from loadkeys. Debian startup scrips do
dumpkeys | sed ... | loadkeys and the loadkeys command fails with the
following messages:
KDSKBENT: Invalid argument
failed to bind key 256 to value 638
KDSKBENT: Invalid argument
failed to bind key 256 to value 638
KDSKBENT: Invalid argument
failed to bind key 256 to value 638
KDSKBENT: Invalid argument
failed to bind key 256 to value 638
KDSKBENT: Invalid argument
failed to bind key 256 to value 638
KDSKBENT: Invalid argument
failed to bind key 256 to value 638
KDSKBENT: Invalid argument
failed to bind key 256 to value 638
KDSKBENT: Invalid argument
failed to bind key 256 to value 638
KDSKBENT: Invalid argument
failed to bind key 256 to value 638

Additionally, when X starts, these two messages appear in dmesg:
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).

With showkeys, there is no key 0x7a=122. Nothing strange in X logs.

dmesg:
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0


And here is dumpkeys output that goes to loadkeys unmodified (since I
don't use remapping - so it's basically dumpkeys | loadkeys):

keymaps 0-15
keycode   1 = Escape           Escape
	alt	keycode   1 = Meta_Escape
	shift	alt	keycode   1 = Meta_Escape
keycode   2 = one              exclam
	alt	keycode   2 = Meta_one
	shift	alt	keycode   2 = Meta_exclam
keycode   3 = two              quotedbl         at               at               nul              nul              nul              nul              Meta_two         Meta_quotedbl    Meta_at          Meta_at          Meta_nul         Meta_nul         Meta_nul         Meta_nul
keycode   4 = three            numbersign       sterling         sterling
	alt	keycode   4 = Meta_three
	shift	alt	keycode   4 = Meta_numbersign
keycode   5 = four             currency         dollar           dollar
	alt	keycode   5 = Meta_four
	altgr	alt	keycode   5 = Meta_dollar
	shift	altgr	alt	keycode   5 = Meta_dollar
keycode   6 = five             percent
	alt	keycode   6 = Meta_five
	shift	alt	keycode   6 = Meta_percent
keycode   7 = six              ampersand
	control	keycode   7 = Control_asciicircum
	shift	control	keycode   7 = Control_asciicircum
	altgr	control	keycode   7 = Control_asciicircum
	shift	altgr	control	keycode   7 = Control_asciicircum
	alt	keycode   7 = Meta_six
	shift	alt	keycode   7 = Meta_ampersand
	control	alt	keycode   7 = Meta_Control_asciicircum
	shift	control	alt	keycode   7 = Meta_Control_asciicircum
	altgr	control	alt	keycode   7 = Meta_Control_asciicircum
	shift	altgr	control	alt	keycode   7 = Meta_Control_asciicircum
keycode   8 = seven            slash            braceleft        braceleft
	alt	keycode   8 = Meta_seven
	shift	alt	keycode   8 = Meta_slash
	altgr	alt	keycode   8 = Meta_braceleft
	shift	altgr	alt	keycode   8 = Meta_braceleft
keycode   9 = eight            parenleft        bracketleft      bracketleft      Escape           Escape           Escape           Escape           Meta_eight       Meta_parenleft   Meta_bracketleft Meta_bracketleft Meta_Escape      Meta_Escape      Meta_Escape      Meta_Escape
keycode  10 = nine             parenright       bracketright     bracketright     Control_bracketright Control_bracketright Control_bracketright Control_bracketright Meta_nine        Meta_parenright  Meta_bracketright Meta_bracketright Meta_Control_bracketright Meta_Control_bracketright Meta_Control_bracketright Meta_Control_bracketright
keycode  11 = zero             equal            braceright       braceright
	alt	keycode  11 = Meta_zero
	shift	alt	keycode  11 = Meta_equal
	altgr	alt	keycode  11 = Meta_braceright
	shift	altgr	alt	keycode  11 = Meta_braceright
keycode  12 = plus             question         backslash        backslash        Control_underscore Control_underscore Control_backslash Control_backslash Meta_plus        Meta_question    Meta_backslash   Meta_backslash   Meta_Control_underscore Meta_Control_underscore Meta_Control_backslash Meta_Control_backslash
keycode  13 = dead_acute       dead_grave       dead_acute       dead_grave
keycode  14 = Delete           Delete
	control	keycode  14 = BackSpace
	alt	keycode  14 = Meta_Delete
	shift	alt	keycode  14 = Meta_Delete
keycode  15 = Tab              Tab
	alt	keycode  15 = Meta_Tab
	shift	alt	keycode  15 = Meta_Tab
keycode  16 = q
keycode  17 = w
keycode  18 = +e                +E                currency         currency         Control_e        Control_e
	alt	keycode  18 = Meta_e
	shift	alt	keycode  18 = Meta_E
	control	alt	keycode  18 = Meta_Control_e
	shift	control	alt	keycode  18 = Meta_Control_e
keycode  19 = r
keycode  20 = t
keycode  21 = y
keycode  22 = u
keycode  23 = i
keycode  24 = o
keycode  25 = p
keycode  26 = +udiaeresis       +Udiaeresis       +udiaeresis       +Udiaeresis       Escape
	control	alt	keycode  26 = Meta_Escape
keycode  27 = +otilde           +Otilde           section          section          Control_bracketright
	control	alt	keycode  27 = Meta_Control_bracketright
keycode  28 = Return
	alt	keycode  28 = Meta_Control_m
keycode  29 = Control
keycode  30 = a
keycode  31 = +s                +S                +diaeresis        +brokenbar        Control_s        Control_s
	alt	keycode  31 = Meta_s
	shift	alt	keycode  31 = Meta_S
	control	alt	keycode  31 = Meta_Control_s
	shift	control	alt	keycode  31 = Meta_Control_s
keycode  32 = d
keycode  33 = f
keycode  34 = g
keycode  35 = h
keycode  36 = j
keycode  37 = k
keycode  38 = l
keycode  39 = +odiaeresis       +Odiaeresis       +odiaeresis       +Odiaeresis
keycode  40 = +adiaeresis       +Adiaeresis       asciicircum      asciicircum      Control_asciicircum Control_asciicircum Control_asciicircum Control_asciicircum
	altgr	alt	keycode  40 = Meta_asciicircum
	shift	altgr	alt	keycode  40 = Meta_asciicircum
	control	alt	keycode  40 = Meta_Control_asciicircum
	shift	control	alt	keycode  40 = Meta_Control_asciicircum
	altgr	control	alt	keycode  40 = Meta_Control_asciicircum
	shift	altgr	control	alt	keycode  40 = Meta_Control_asciicircum
keycode  41 = dead_circumflex  dead_tilde       dead_circumflex  dead_tilde       dead_diaeresis
keycode  42 = Shift
keycode  43 = apostrophe       asterisk         onehalf          onehalf          Control_backslash Control_backslash
	alt	keycode  43 = Meta_apostrophe
	shift	alt	keycode  43 = Meta_asterisk
	control	alt	keycode  43 = Meta_Control_backslash
	shift	control	alt	keycode  43 = Meta_Control_backslash
keycode  44 = +z                +Z                +cedilla          +acute            Control_z        Control_z
	alt	keycode  44 = Meta_z
	shift	alt	keycode  44 = Meta_Z
	control	alt	keycode  44 = Meta_Control_z
	shift	control	alt	keycode  44 = Meta_Control_z
keycode  45 = x
keycode  46 = c
keycode  47 = v
keycode  48 = b
keycode  49 = n
keycode  50 = m
keycode  51 = comma            semicolon
	alt	keycode  51 = Meta_comma
	shift	alt	keycode  51 = Meta_semicolon
keycode  52 = period           colon
	control	keycode  52 = Compose
	alt	keycode  52 = Meta_period
	shift	alt	keycode  52 = Meta_colon
keycode  53 = minus            underscore
	control	keycode  53 = Control_underscore
	shift	control	keycode  53 = Control_underscore
	alt	keycode  53 = Meta_minus
	shift	alt	keycode  53 = Meta_underscore
	control	alt	keycode  53 = Meta_Control_underscore
	shift	control	alt	keycode  53 = Meta_Control_underscore
keycode  54 = Shift
keycode  55 = KP_Multiply
	altgr	keycode  55 = Hex_C
keycode  56 = Alt
keycode  57 = space            space
	control	keycode  57 = nul
	alt	keycode  57 = Meta_space
	shift	alt	keycode  57 = Meta_space
keycode  58 = Caps_Lock
keycode  59 = F1               F13              Console_13
	control	keycode  59 = F25
	alt	keycode  59 = Console_1
	control	alt	keycode  59 = Console_1
keycode  60 = F2               F14              Console_14
	control	keycode  60 = F26
	alt	keycode  60 = Console_2
	control	alt	keycode  60 = Console_2
keycode  61 = F3               F15              Console_15
	control	keycode  61 = F27
	alt	keycode  61 = Console_3
	control	alt	keycode  61 = Console_3
keycode  62 = F4               F16              Console_16
	control	keycode  62 = F28
	alt	keycode  62 = Console_4
	control	alt	keycode  62 = Console_4
keycode  63 = F5               F17              Console_17
	control	keycode  63 = F29
	alt	keycode  63 = Console_5
	control	alt	keycode  63 = Console_5
keycode  64 = F6               F18              Console_18
	control	keycode  64 = F30
	alt	keycode  64 = Console_6
	control	alt	keycode  64 = Console_6
keycode  65 = F7               F19              Console_19
	control	keycode  65 = F31
	alt	keycode  65 = Console_7
	control	alt	keycode  65 = Console_7
keycode  66 = F8               F20              Console_20
	control	keycode  66 = F32
	alt	keycode  66 = Console_8
	control	alt	keycode  66 = Console_8
keycode  67 = F9               F21              Console_21
	control	keycode  67 = F33
	alt	keycode  67 = Console_9
	control	alt	keycode  67 = Console_9
keycode  68 = F10              F22              Console_22
	control	keycode  68 = F34
	alt	keycode  68 = Console_10
	control	alt	keycode  68 = Console_10
keycode  69 = Num_Lock
	altgr	keycode  69 = Hex_A
keycode  70 = Scroll_Lock      Show_Memory      Show_Registers
	control	keycode  70 = Show_State
	alt	keycode  70 = Scroll_Lock
keycode  71 = KP_7
	altgr	keycode  71 = Hex_7
	alt	keycode  71 = Ascii_7
keycode  72 = KP_8
	altgr	keycode  72 = Hex_8
	alt	keycode  72 = Ascii_8
keycode  73 = KP_9
	altgr	keycode  73 = Hex_9
	alt	keycode  73 = Ascii_9
keycode  74 = KP_Subtract
	altgr	keycode  74 = Hex_D
keycode  75 = KP_4
	altgr	keycode  75 = Hex_4
	alt	keycode  75 = Ascii_4
keycode  76 = KP_5
	altgr	keycode  76 = Hex_5
	alt	keycode  76 = Ascii_5
keycode  77 = KP_6
	altgr	keycode  77 = Hex_6
	alt	keycode  77 = Ascii_6
keycode  78 = KP_Add
	altgr	keycode  78 = Hex_E
keycode  79 = KP_1
	altgr	keycode  79 = Hex_1
	alt	keycode  79 = Ascii_1
keycode  80 = KP_2
	altgr	keycode  80 = Hex_2
	alt	keycode  80 = Ascii_2
keycode  81 = KP_3
	altgr	keycode  81 = Hex_3
	alt	keycode  81 = Ascii_3
keycode  82 = KP_0
	altgr	keycode  82 = Hex_0
	alt	keycode  82 = Ascii_0
keycode  83 = KP_Comma
keycode  84 = Last_Console
keycode  85 =
keycode  86 = less             greater          bar              bar
	alt	keycode  86 = Meta_less
	shift	alt	keycode  86 = Meta_greater
	altgr	alt	keycode  86 = Meta_bar
	shift	altgr	alt	keycode  86 = Meta_bar
keycode  87 = F11              F23              Console_23
	control	keycode  87 = F35
	alt	keycode  87 = Console_11
	control	alt	keycode  87 = Console_11
keycode  88 = F12              F24              Console_24
	control	keycode  88 = F36
	alt	keycode  88 = Console_12
	control	alt	keycode  88 = Console_12
keycode  89 =
keycode  90 =
keycode  91 =
keycode  92 =
keycode  93 =
keycode  94 =
keycode  95 =
keycode  96 = KP_Enter
	altgr	keycode  96 = Hex_F
keycode  97 = Control
keycode  98 = KP_Divide
	altgr	keycode  98 = Hex_B
keycode  99 = Control_backslash
	alt	keycode  99 = Meta_Control_backslash
	shift	alt	keycode  99 = Meta_Control_backslash
	altgr	alt	keycode  99 = Meta_Control_backslash
	shift	altgr	alt	keycode  99 = Meta_Control_backslash
	control	alt	keycode  99 = Meta_Control_backslash
	shift	control	alt	keycode  99 = Meta_Control_backslash
	altgr	control	alt	keycode  99 = Meta_Control_backslash
	shift	altgr	control	alt	keycode  99 = Meta_Control_backslash
keycode 100 = AltGr
keycode 101 = Break
keycode 102 = Find
keycode 103 = Up
	alt	keycode 103 = KeyboardSignal
keycode 104 = Prior
	shift	keycode 104 = Scroll_Backward
keycode 105 = Left
	alt	keycode 105 = Decr_Console
keycode 106 = Right
	alt	keycode 106 = Incr_Console
keycode 107 = Select
keycode 108 = Down
keycode 109 = Next
	shift	keycode 109 = Scroll_Forward
keycode 110 = Insert
keycode 111 = Remove
	altgr	control	keycode 111 = Boot
	control	alt	keycode 111 = Boot
keycode 112 = Macro            Macro            Macro
	control	keycode 112 = Macro
	shift	control	keycode 112 = Macro
	alt	keycode 112 = Macro
	control	alt	keycode 112 = Macro
keycode 113 = F13              F13              F13
	control	keycode 113 = F13
	shift	control	keycode 113 = F13
	alt	keycode 113 = F13
	control	alt	keycode 113 = F13
keycode 114 = F14              F14              F14
	control	keycode 114 = F14
	shift	control	keycode 114 = F14
	alt	keycode 114 = F14
	control	alt	keycode 114 = F14
keycode 115 = Help             Help             Help
	control	keycode 115 = Help
	shift	control	keycode 115 = Help
	alt	keycode 115 = Help
	control	alt	keycode 115 = Help
keycode 116 = Do               Do               Do
	control	keycode 116 = Do
	shift	control	keycode 116 = Do
	alt	keycode 116 = Do
	control	alt	keycode 116 = Do
keycode 117 = F17              F17              F17
	control	keycode 117 = F17
	shift	control	keycode 117 = F17
	alt	keycode 117 = F17
	control	alt	keycode 117 = F17
keycode 118 = KP_MinPlus       KP_MinPlus       KP_MinPlus
	control	keycode 118 = KP_MinPlus
	shift	control	keycode 118 = KP_MinPlus
	alt	keycode 118 = KP_MinPlus
	control	alt	keycode 118 = KP_MinPlus
keycode 119 = Pause
keycode 120 =
keycode 121 =
keycode 122 =
keycode 123 =
keycode 124 =
keycode 125 =
keycode 126 =
keycode 127 = Compose
keycode 128 =
keycode 129 =
keycode 130 =
keycode 131 =
keycode 132 =
keycode 133 =
keycode 134 =
keycode 135 =
keycode 136 =
keycode 137 =
keycode 138 =
keycode 139 =
keycode 140 =
keycode 141 =
keycode 142 =
keycode 143 =
keycode 144 =
keycode 145 =
keycode 146 =
keycode 147 =
keycode 148 =
keycode 149 =
keycode 150 =
keycode 151 =
keycode 152 =
keycode 153 =
keycode 154 =
keycode 155 =
keycode 156 =
keycode 157 =
keycode 158 =
keycode 159 =
keycode 160 =
keycode 161 =
keycode 162 =
keycode 163 =
keycode 164 =
keycode 165 =
keycode 166 =
keycode 167 =
keycode 168 =
keycode 169 =
keycode 170 =
keycode 171 =
keycode 172 =
keycode 173 =
keycode 174 =
keycode 175 =
keycode 176 =
keycode 177 =
keycode 178 =
keycode 179 =
keycode 180 =
keycode 181 =
keycode 182 =
keycode 183 =
keycode 184 =
keycode 185 =
keycode 186 =
keycode 187 =
keycode 188 =
keycode 189 =
keycode 190 =
keycode 191 =
keycode 192 =
keycode 193 =
keycode 194 =
keycode 195 =
keycode 196 =
keycode 197 =
keycode 198 =
keycode 199 =
keycode 200 =
keycode 201 =
keycode 202 =
keycode 203 =
keycode 204 =
keycode 205 =
keycode 206 =
keycode 207 =
keycode 208 =
keycode 209 =
keycode 210 =
keycode 211 =
keycode 212 =
keycode 213 =
keycode 214 =
keycode 215 =
keycode 216 =
keycode 217 =
keycode 218 =
keycode 219 =
keycode 220 =
keycode 221 =
keycode 222 =
keycode 223 =
keycode 224 =
keycode 225 =
keycode 226 =
keycode 227 =
keycode 228 =
keycode 229 =
keycode 230 =
keycode 231 =
keycode 232 =
keycode 233 =
keycode 234 =
keycode 235 =
keycode 236 =
keycode 237 =
keycode 238 =
keycode 239 =
keycode 240 =
keycode 241 =
keycode 242 =
keycode 243 =
keycode 244 =
keycode 245 =
keycode 246 =
keycode 247 =
keycode 248 =
keycode 249 =
keycode 250 =
keycode 251 =
keycode 252 =
keycode 253 =
keycode 254 =
keycode 255 =
keycode 256 =
	shift	altgr	keycode 256 = 0x027e
	altgr	control	keycode 256 = 0x027e
	shift	altgr	control	keycode 256 = 0x027e
	shift	alt	keycode 256 = 0x027e
	altgr	alt	keycode 256 = 0x027e
	shift	altgr	alt	keycode 256 = 0x027e
	shift	control	alt	keycode 256 = 0x027e
	altgr	control	alt	keycode 256 = 0x027e
	shift	altgr	control	alt	keycode 256 = 0x027e
keycode 257 = Escape           Escape
	alt	keycode 257 = Meta_Escape
	shift	alt	keycode 257 = Meta_Escape
keycode 258 = one              exclam
	alt	keycode 258 = Meta_one
	shift	alt	keycode 258 = Meta_exclam
keycode 259 = two              quotedbl         at               at               nul              nul              nul              nul              Meta_two         Meta_quotedbl    Meta_at          Meta_at          Meta_nul         Meta_nul         Meta_nul         Meta_nul
keycode 260 = three            numbersign       sterling         sterling
	alt	keycode 260 = Meta_three
	shift	alt	keycode 260 = Meta_numbersign
keycode 261 = four             currency         dollar           dollar
	alt	keycode 261 = Meta_four
	altgr	alt	keycode 261 = Meta_dollar
	shift	altgr	alt	keycode 261 = Meta_dollar
keycode 262 = five             percent
	alt	keycode 262 = Meta_five
	shift	alt	keycode 262 = Meta_percent
keycode 263 = six              ampersand
	control	keycode 263 = Control_asciicircum
	shift	control	keycode 263 = Control_asciicircum
	altgr	control	keycode 263 = Control_asciicircum
	shift	altgr	control	keycode 263 = Control_asciicircum
	alt	keycode 263 = Meta_six
	shift	alt	keycode 263 = Meta_ampersand
	control	alt	keycode 263 = Meta_Control_asciicircum
	shift	control	alt	keycode 263 = Meta_Control_asciicircum
	altgr	control	alt	keycode 263 = Meta_Control_asciicircum
	shift	altgr	control	alt	keycode 263 = Meta_Control_asciicircum
keycode 264 = seven            slash            braceleft        braceleft
	alt	keycode 264 = Meta_seven
	shift	alt	keycode 264 = Meta_slash
	altgr	alt	keycode 264 = Meta_braceleft
	shift	altgr	alt	keycode 264 = Meta_braceleft
keycode 265 = eight            parenleft        bracketleft      bracketleft      Escape           Escape           Escape           Escape           Meta_eight       Meta_parenleft   Meta_bracketleft Meta_bracketleft Meta_Escape      Meta_Escape      Meta_Escape      Meta_Escape
keycode 266 = nine             parenright       bracketright     bracketright     Control_bracketright Control_bracketright Control_bracketright Control_bracketright Meta_nine        Meta_parenright  Meta_bracketright Meta_bracketright Meta_Control_bracketright Meta_Control_bracketright Meta_Control_bracketright Meta_Control_bracketright
keycode 267 = zero             equal            braceright       braceright
	alt	keycode 267 = Meta_zero
	shift	alt	keycode 267 = Meta_equal
	altgr	alt	keycode 267 = Meta_braceright
	shift	altgr	alt	keycode 267 = Meta_braceright
keycode 268 = plus             question         backslash        backslash        Control_underscore Control_underscore Control_backslash Control_backslash Meta_plus        Meta_question    Meta_backslash   Meta_backslash   Meta_Control_underscore Meta_Control_underscore Meta_Control_backslash Meta_Control_backslash
keycode 269 = dead_acute       dead_grave       dead_acute       dead_grave
keycode 270 = Delete           Delete
	control	keycode 270 = BackSpace
	alt	keycode 270 = Meta_Delete
	shift	alt	keycode 270 = Meta_Delete
keycode 271 = Tab              Tab
	alt	keycode 271 = Meta_Tab
	shift	alt	keycode 271 = Meta_Tab
keycode 272 = q
keycode 273 = w
keycode 274 = +e                +E                currency         currency         Control_e        Control_e
	alt	keycode 274 = Meta_e
	shift	alt	keycode 274 = Meta_E
	control	alt	keycode 274 = Meta_Control_e
	shift	control	alt	keycode 274 = Meta_Control_e
keycode 275 = r
keycode 276 = t
keycode 277 = y
keycode 278 = u
keycode 279 = i
keycode 280 = o
keycode 281 = p
keycode 282 = +udiaeresis       +Udiaeresis       +udiaeresis       +Udiaeresis       Escape
	control	alt	keycode 282 = Meta_Escape
keycode 283 = +otilde           +Otilde           section          section          Control_bracketright
	control	alt	keycode 283 = Meta_Control_bracketright
keycode 284 = Return
	alt	keycode 284 = Meta_Control_m
keycode 285 = Control
keycode 286 = a
keycode 287 = +s                +S                +diaeresis        +brokenbar        Control_s        Control_s
	alt	keycode 287 = Meta_s
	shift	alt	keycode 287 = Meta_S
	control	alt	keycode 287 = Meta_Control_s
	shift	control	alt	keycode 287 = Meta_Control_s
keycode 288 = d
keycode 289 = f
keycode 290 = g
keycode 291 = h
keycode 292 = j
keycode 293 = k
keycode 294 = l
keycode 295 = +odiaeresis       +Odiaeresis       +odiaeresis       +Odiaeresis
keycode 296 = +adiaeresis       +Adiaeresis       asciicircum      asciicircum      Control_asciicircum Control_asciicircum Control_asciicircum Control_asciicircum
	altgr	alt	keycode 296 = Meta_asciicircum
	shift	altgr	alt	keycode 296 = Meta_asciicircum
	control	alt	keycode 296 = Meta_Control_asciicircum
	shift	control	alt	keycode 296 = Meta_Control_asciicircum
	altgr	control	alt	keycode 296 = Meta_Control_asciicircum
	shift	altgr	control	alt	keycode 296 = Meta_Control_asciicircum
keycode 297 = dead_circumflex  dead_tilde       dead_circumflex  dead_tilde       dead_diaeresis
keycode 298 = Shift
keycode 299 = apostrophe       asterisk         onehalf          onehalf          Control_backslash Control_backslash
	alt	keycode 299 = Meta_apostrophe
	shift	alt	keycode 299 = Meta_asterisk
	control	alt	keycode 299 = Meta_Control_backslash
	shift	control	alt	keycode 299 = Meta_Control_backslash
keycode 300 = +z                +Z                +cedilla          +acute            Control_z        Control_z
	alt	keycode 300 = Meta_z
	shift	alt	keycode 300 = Meta_Z
	control	alt	keycode 300 = Meta_Control_z
	shift	control	alt	keycode 300 = Meta_Control_z
keycode 301 = x
keycode 302 = c
keycode 303 = v
keycode 304 = b
keycode 305 = n
keycode 306 = m
keycode 307 = comma            semicolon
	alt	keycode 307 = Meta_comma
	shift	alt	keycode 307 = Meta_semicolon
keycode 308 = period           colon
	control	keycode 308 = Compose
	alt	keycode 308 = Meta_period
	shift	alt	keycode 308 = Meta_colon
keycode 309 = minus            underscore
	control	keycode 309 = Control_underscore
	shift	control	keycode 309 = Control_underscore
	alt	keycode 309 = Meta_minus
	shift	alt	keycode 309 = Meta_underscore
	control	alt	keycode 309 = Meta_Control_underscore
	shift	control	alt	keycode 309 = Meta_Control_underscore
keycode 310 = Shift
keycode 311 = KP_Multiply
	altgr	keycode 311 = Hex_C
keycode 312 = Alt
keycode 313 = space            space
	control	keycode 313 = nul
	alt	keycode 313 = Meta_space
	shift	alt	keycode 313 = Meta_space
keycode 314 = Caps_Lock
keycode 315 = F1               F13              Console_13
	control	keycode 315 = F25
	alt	keycode 315 = Console_1
	control	alt	keycode 315 = Console_1
keycode 316 = F2               F14              Console_14
	control	keycode 316 = F26
	alt	keycode 316 = Console_2
	control	alt	keycode 316 = Console_2
keycode 317 = F3               F15              Console_15
	control	keycode 317 = F27
	alt	keycode 317 = Console_3
	control	alt	keycode 317 = Console_3
keycode 318 = F4               F16              Console_16
	control	keycode 318 = F28
	alt	keycode 318 = Console_4
	control	alt	keycode 318 = Console_4
keycode 319 = F5               F17              Console_17
	control	keycode 319 = F29
	alt	keycode 319 = Console_5
	control	alt	keycode 319 = Console_5
keycode 320 = F6               F18              Console_18
	control	keycode 320 = F30
	alt	keycode 320 = Console_6
	control	alt	keycode 320 = Console_6
keycode 321 = F7               F19              Console_19
	control	keycode 321 = F31
	alt	keycode 321 = Console_7
	control	alt	keycode 321 = Console_7
keycode 322 = F8               F20              Console_20
	control	keycode 322 = F32
	alt	keycode 322 = Console_8
	control	alt	keycode 322 = Console_8
keycode 323 = F9               F21              Console_21
	control	keycode 323 = F33
	alt	keycode 323 = Console_9
	control	alt	keycode 323 = Console_9
keycode 324 = F10              F22              Console_22
	control	keycode 324 = F34
	alt	keycode 324 = Console_10
	control	alt	keycode 324 = Console_10
keycode 325 = Num_Lock
	altgr	keycode 325 = Hex_A
keycode 326 = Scroll_Lock      Show_Memory      Show_Registers
	control	keycode 326 = Show_State
	alt	keycode 326 = Scroll_Lock
keycode 327 = KP_7
	altgr	keycode 327 = Hex_7
	alt	keycode 327 = Ascii_7
keycode 328 = KP_8
	altgr	keycode 328 = Hex_8
	alt	keycode 328 = Ascii_8
keycode 329 = KP_9
	altgr	keycode 329 = Hex_9
	alt	keycode 329 = Ascii_9
keycode 330 = KP_Subtract
	altgr	keycode 330 = Hex_D
keycode 331 = KP_4
	altgr	keycode 331 = Hex_4
	alt	keycode 331 = Ascii_4
keycode 332 = KP_5
	altgr	keycode 332 = Hex_5
	alt	keycode 332 = Ascii_5
keycode 333 = KP_6
	altgr	keycode 333 = Hex_6
	alt	keycode 333 = Ascii_6
keycode 334 = KP_Add
	altgr	keycode 334 = Hex_E
keycode 335 = KP_1
	altgr	keycode 335 = Hex_1
	alt	keycode 335 = Ascii_1
keycode 336 = KP_2
	altgr	keycode 336 = Hex_2
	alt	keycode 336 = Ascii_2
keycode 337 = KP_3
	altgr	keycode 337 = Hex_3
	alt	keycode 337 = Ascii_3
keycode 338 = KP_0
	altgr	keycode 338 = Hex_0
	alt	keycode 338 = Ascii_0
keycode 339 = KP_Comma
keycode 340 = Last_Console
keycode 341 =
keycode 342 = less             greater          bar              bar
	alt	keycode 342 = Meta_less
	shift	alt	keycode 342 = Meta_greater
	altgr	alt	keycode 342 = Meta_bar
	shift	altgr	alt	keycode 342 = Meta_bar
keycode 343 = F11              F23              Console_23
	control	keycode 343 = F35
	alt	keycode 343 = Console_11
	control	alt	keycode 343 = Console_11
keycode 344 = F12              F24              Console_24
	control	keycode 344 = F36
	alt	keycode 344 = Console_12
	control	alt	keycode 344 = Console_12
keycode 345 =
keycode 346 =
keycode 347 =
keycode 348 =
keycode 349 =
keycode 350 =
keycode 351 =
keycode 352 = KP_Enter
	altgr	keycode 352 = Hex_F
keycode 353 = Control
keycode 354 = KP_Divide
	altgr	keycode 354 = Hex_B
keycode 355 = Control_backslash
	alt	keycode 355 = Meta_Control_backslash
	shift	alt	keycode 355 = Meta_Control_backslash
	altgr	alt	keycode 355 = Meta_Control_backslash
	shift	altgr	alt	keycode 355 = Meta_Control_backslash
	control	alt	keycode 355 = Meta_Control_backslash
	shift	control	alt	keycode 355 = Meta_Control_backslash
	altgr	control	alt	keycode 355 = Meta_Control_backslash
	shift	altgr	control	alt	keycode 355 = Meta_Control_backslash
keycode 356 = AltGr
keycode 357 = Break
keycode 358 = Find
keycode 359 = Up
	alt	keycode 359 = KeyboardSignal
keycode 360 = Prior
	shift	keycode 360 = Scroll_Backward
keycode 361 = Left
	alt	keycode 361 = Decr_Console
keycode 362 = Right
	alt	keycode 362 = Incr_Console
keycode 363 = Select
keycode 364 = Down
keycode 365 = Next
	shift	keycode 365 = Scroll_Forward
keycode 366 = Insert
keycode 367 = Remove
	altgr	control	keycode 367 = Boot
	control	alt	keycode 367 = Boot
keycode 368 = Macro            Macro            Macro
	control	keycode 368 = Macro
	shift	control	keycode 368 = Macro
	alt	keycode 368 = Macro
	control	alt	keycode 368 = Macro
keycode 369 = F13              F13              F13
	control	keycode 369 = F13
	shift	control	keycode 369 = F13
	alt	keycode 369 = F13
	control	alt	keycode 369 = F13
keycode 370 = F14              F14              F14
	control	keycode 370 = F14
	shift	control	keycode 370 = F14
	alt	keycode 370 = F14
	control	alt	keycode 370 = F14
keycode 371 = Help             Help             Help
	control	keycode 371 = Help
	shift	control	keycode 371 = Help
	alt	keycode 371 = Help
	control	alt	keycode 371 = Help
keycode 372 = Do               Do               Do
	control	keycode 372 = Do
	shift	control	keycode 372 = Do
	alt	keycode 372 = Do
	control	alt	keycode 372 = Do
keycode 373 = F17              F17              F17
	control	keycode 373 = F17
	shift	control	keycode 373 = F17
	alt	keycode 373 = F17
	control	alt	keycode 373 = F17
keycode 374 = KP_MinPlus       KP_MinPlus       KP_MinPlus
	control	keycode 374 = KP_MinPlus
	shift	control	keycode 374 = KP_MinPlus
	alt	keycode 374 = KP_MinPlus
	control	alt	keycode 374 = KP_MinPlus
keycode 375 = Pause
keycode 376 =
keycode 377 =
keycode 378 =
keycode 379 =
keycode 380 =
keycode 381 =
keycode 382 =
keycode 383 = Compose
keycode 384 =
keycode 385 =
keycode 386 =
keycode 387 =
keycode 388 =
keycode 389 =
keycode 390 =
keycode 391 =
keycode 392 =
keycode 393 =
keycode 394 =
keycode 395 =
keycode 396 =
keycode 397 =
keycode 398 =
keycode 399 =
keycode 400 =
keycode 401 =
keycode 402 =
keycode 403 =
keycode 404 =
keycode 405 =
keycode 406 =
keycode 407 =
keycode 408 =
keycode 409 =
keycode 410 =
keycode 411 =
keycode 412 =
keycode 413 =
keycode 414 =
keycode 415 =
keycode 416 =
keycode 417 =
keycode 418 =
keycode 419 =
keycode 420 =
keycode 421 =
keycode 422 =
keycode 423 =
keycode 424 =
keycode 425 =
keycode 426 =
keycode 427 =
keycode 428 =
keycode 429 =
keycode 430 =
keycode 431 =
keycode 432 =
keycode 433 =
keycode 434 =
keycode 435 =
keycode 436 =
keycode 437 =
keycode 438 =
keycode 439 =
keycode 440 =
keycode 441 =
keycode 442 =
keycode 443 =
keycode 444 =
keycode 445 =
keycode 446 =
keycode 447 =
keycode 448 =
keycode 449 =
keycode 450 =
keycode 451 =
keycode 452 =
keycode 453 =
keycode 454 =
keycode 455 =
keycode 456 =
keycode 457 =
keycode 458 =
keycode 459 =
keycode 460 =
keycode 461 =
keycode 462 =
keycode 463 =
keycode 464 =
keycode 465 =
keycode 466 =
keycode 467 =
keycode 468 =
keycode 469 =
keycode 470 =
keycode 471 =
keycode 472 =
keycode 473 =
keycode 474 =
keycode 475 =
keycode 476 =
keycode 477 =
keycode 478 =
keycode 479 =
keycode 480 =
keycode 481 =
keycode 482 =
keycode 483 =
keycode 484 =
keycode 485 =
keycode 486 =
keycode 487 =
keycode 488 =
keycode 489 =
keycode 490 =
keycode 491 =
keycode 492 =
keycode 493 =
keycode 494 =
keycode 495 =
keycode 496 =
keycode 497 =
keycode 498 =
keycode 499 =
keycode 500 =
keycode 501 =
keycode 502 =
keycode 503 =
keycode 504 =
keycode 505 =
keycode 506 =
keycode 507 =
keycode 508 =
keycode 509 =
keycode 510 =
keycode 511 =
string F1 = "\033[[A"
string F2 = "\033[[B"
string F3 = "\033[[C"
string F4 = "\033[[D"
string F5 = "\033[[E"
string F6 = "\033[17~"
string F7 = "\033[18~"
string F8 = "\033[19~"
string F9 = "\033[20~"
string F10 = "\033[21~"
string F11 = "\033[23~"
string F12 = "\033[24~"
string F13 = "\033[25~"
string F14 = "\033[26~"
string F15 = "\033[28~"
string F16 = "\033[29~"
string F17 = "\033[31~"
string F18 = "\033[32~"
string F19 = "\033[33~"
string F20 = "\033[34~"
string Find = "\033[1~"
string Insert = "\033[2~"
string Remove = "\033[3~"
string Select = "\033[4~"
string Prior = "\033[5~"
string Next = "\033[6~"
string Macro = "\033[M"
string Pause = "\033[P"
compose '`' 'A' to 'À'
compose '`' 'a' to 'à'
compose '\'' 'A' to 'Á'
compose '\'' 'a' to 'á'
compose '^' 'A' to 'Â'
compose '^' 'a' to 'â'
compose '~' 'A' to 'Ã'
compose '~' 'a' to 'ã'
compose '"' 'A' to 'Ä'
compose '"' 'a' to 'ä'
compose 'O' 'A' to 'Å'
compose 'o' 'a' to 'å'
compose '0' 'A' to 'Å'
compose '0' 'a' to 'å'
compose 'A' 'A' to 'Å'
compose 'a' 'a' to 'å'
compose 'A' 'E' to 'Æ'
compose 'a' 'e' to 'æ'
compose ',' 'C' to 'Ç'
compose ',' 'c' to 'ç'
compose '`' 'E' to 'È'
compose '`' 'e' to 'è'
compose '\'' 'E' to 'É'
compose '\'' 'e' to 'é'
compose '^' 'E' to 'Ê'
compose '^' 'e' to 'ê'
compose '"' 'E' to 'Ë'
compose '"' 'e' to 'ë'
compose '`' 'I' to 'Ì'
compose '`' 'i' to 'ì'
compose '\'' 'I' to 'Í'
compose '\'' 'i' to 'í'
compose '^' 'I' to 'Î'
compose '^' 'i' to 'î'
compose '"' 'I' to 'Ï'
compose '"' 'i' to 'ï'
compose '-' 'D' to 'Ð'
compose '-' 'd' to 'ð'
compose '~' 'N' to 'Ñ'
compose '~' 'n' to 'ñ'
compose '`' 'O' to 'Ò'
compose '`' 'o' to 'ò'
compose '\'' 'O' to 'Ó'
compose '\'' 'o' to 'ó'
compose '^' 'O' to 'Ô'
compose '^' 'o' to 'ô'
compose '~' 'O' to 'Õ'
compose '~' 'o' to 'õ'
compose '"' 'O' to 'Ö'
compose '"' 'o' to 'ö'
compose '/' 'O' to 'Ø'
compose '/' 'o' to 'ø'
compose '`' 'U' to 'Ù'
compose '`' 'u' to 'ù'
compose '\'' 'U' to 'Ú'
compose '\'' 'u' to 'ú'
compose '^' 'U' to 'Û'
compose '^' 'u' to 'û'
compose '"' 'U' to 'Ü'
compose '"' 'u' to 'ü'
compose '\'' 'Y' to 'Ý'
compose '\'' 'y' to 'ý'
compose 'T' 'H' to 'Þ'
compose 't' 'h' to 'þ'
compose 's' 's' to 'ß'
compose '"' 'y' to 'ÿ'
compose 's' 'z' to 'ß'
compose 'i' 'j' to 'ÿ'
compose '^' 's' to '¨'
compose '^' 'S' to '¦'
compose '^' 'z' to '¸'
compose '^' 'Z' to '´'
compose 'o' 'e' to '½'
compose 'O' 'E' to '¼'
compose '"' 'Y' to '¾'
compose 'I' 'J' to '¾'
compose '=' 'c' to '¤'
compose '=' 'C' to '¤'

-- 
Meelis Roos (mroos@linux.ee)

