Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266347AbSLTXcc>; Fri, 20 Dec 2002 18:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266356AbSLTXcb>; Fri, 20 Dec 2002 18:32:31 -0500
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.222]:9656 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S266347AbSLTXcN>; Fri, 20 Dec 2002 18:32:13 -0500
Message-ID: <3E03A9D8.4040506@nyc.rr.com>
Date: Fri, 20 Dec 2002 18:38:00 -0500
From: John Weber <weber@nyc.rr.com>
Organization: My House
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021210 Debian/1.2.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: James Simmons <jsimmons@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: 2.5.x Cirrus Logic Framebuffer Support
References: <Pine.LNX.4.44.0212202122040.11087-100000@phoenix.infradead.org>
In-Reply-To: <Pine.LNX.4.44.0212202122040.11087-100000@phoenix.infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:
> Applied.
> 

What's the status of framebuffer support for cirrus logic cards?

I recently tried to compile it, and got a bunch of errors resulting from 
what appears to be directory structure and api changes.
If this hasn't already been fixed, then I'll give it a shot.

Full error log below:

drivers/video/clgenfb.c:66: video/fbcon.h: No such file or directory
drivers/video/clgenfb.c:67: video/fbcon-mfb.h: No such file or directory
drivers/video/clgenfb.c:68: video/fbcon-cfb8.h: No such file or directory
drivers/video/clgenfb.c:69: video/fbcon-cfb16.h: No such file or directory
drivers/video/clgenfb.c:70: video/fbcon-cfb24.h: No such file or directory
drivers/video/clgenfb.c:71: video/fbcon-cfb32.h: No such file or directory
drivers/video/clgenfb.c:74: vga.h: No such file or directory
drivers/video/clgenfb.c:505: unknown field `fb_get_fix' specified in 
initializer
drivers/video/clgenfb.c:505: `fbgen_get_fix' undeclared here (not in a 
function)
drivers/video/clgenfb.c:505: initializer element is not constant
drivers/video/clgenfb.c:505: (near initialization for `clgenfb_ops.fb_read')
drivers/video/clgenfb.c:506: unknown field `fb_get_var' specified in 
initializer
drivers/video/clgenfb.c:506: `fbgen_get_var' undeclared here (not in a 
function)
drivers/video/clgenfb.c:506: initializer element is not constant
drivers/video/clgenfb.c:506: (near initialization for 
`clgenfb_ops.fb_write')
drivers/video/clgenfb.c:507: unknown field `fb_set_var' specified in 
initializer
drivers/video/clgenfb.c:507: `fbgen_set_var' undeclared here (not in a 
function)
drivers/video/clgenfb.c:507: initializer element is not constant
drivers/video/clgenfb.c:507: (near initialization for 
`clgenfb_ops.fb_check_var')
drivers/video/clgenfb.c:508: unknown field `fb_get_cmap' specified in 
initialize
r
drivers/video/clgenfb.c:508: `fbgen_get_cmap' undeclared here (not in a 
function
)
drivers/video/clgenfb.c:508: initializer element is not constant
drivers/video/clgenfb.c:508: (near initialization for 
`clgenfb_ops.fb_set_par')
drivers/video/clgenfb.c:509: unknown field `fb_set_cmap' specified in 
initialize
r
drivers/video/clgenfb.c:509: `gen_set_cmap' undeclared here (not in a 
function)
drivers/video/clgenfb.c:509: initializer element is not constant
drivers/video/clgenfb.c:509: (near initialization for 
`clgenfb_ops.fb_setcolreg'
)
drivers/video/clgenfb.c:510: field `fb_setcolreg' already initialized
drivers/video/clgenfb.c:510: warning: initialization from incompatible 
pointer t
ype
drivers/video/clgenfb.c:511: `fbgen_pan_display' undeclared here (not in 
a funct
ion)
drivers/video/clgenfb.c:511: initializer element is not constant
drivers/video/clgenfb.c:511: (near initialization for 
`clgenfb_ops.fb_pan_displa
y')
drivers/video/clgenfb.c:512: field `fb_blank' already initialized
drivers/video/clgenfb.c:512: `fbgen_blank' undeclared here (not in a 
function)
drivers/video/clgenfb.c:512: initializer element is not constant
drivers/video/clgenfb.c:512: (near initialization for 
`clgenfb_ops.fb_fillrect')
drivers/video/clgenfb.c:536: variable `clgen_hwswitch' has initializer 
but incom
plete type
drivers/video/clgenfb.c:538: warning: excess elements in struct initializer
drivers/video/clgenfb.c:538: warning: (near initialization for 
`clgen_hwswitch')
drivers/video/clgenfb.c:539: warning: excess elements in struct initializer
drivers/video/clgenfb.c:539: warning: (near initialization for 
`clgen_hwswitch')
drivers/video/clgenfb.c:540: warning: excess elements in struct initializer
drivers/video/clgenfb.c:540: warning: (near initialization for 
`clgen_hwswitch')
drivers/video/clgenfb.c:541: warning: excess elements in struct initializer
drivers/video/clgenfb.c:541: warning: (near initialization for 
`clgen_hwswitch')
drivers/video/clgenfb.c:542: warning: excess elements in struct initializer
drivers/video/clgenfb.c:542: warning: (near initialization for 
`clgen_hwswitch')
drivers/video/clgenfb.c:543: warning: excess elements in struct initializer
drivers/video/clgenfb.c:543: warning: (near initialization for 
`clgen_hwswitch')
drivers/video/clgenfb.c:544: warning: excess elements in struct initializer
drivers/video/clgenfb.c:544: warning: (near initialization for 
`clgen_hwswitch')
drivers/video/clgenfb.c:545: warning: excess elements in struct initializer
drivers/video/clgenfb.c:545: warning: (near initialization for 
`clgen_hwswitch')
drivers/video/clgenfb.c:546: warning: excess elements in struct initializer
drivers/video/clgenfb.c:546: warning: (near initialization for 
`clgen_hwswitch')
drivers/video/clgenfb.c:548: warning: excess elements in struct initializer
drivers/video/clgenfb.c:548: warning: (near initialization for 
`clgen_hwswitch')
drivers/video/clgenfb.c: In function `clgen_set_mclk':
drivers/video/clgenfb.c:1098: warning: implicit declaration of function 
`vga_rse
q'
drivers/video/clgenfb.c:1099: warning: implicit declaration of function 
`vga_wse
q'
drivers/video/clgenfb.c: In function `clgen_set_par':
drivers/video/clgenfb.c:1133: warning: implicit declaration of function 
`vga_wcr
t'
drivers/video/clgenfb.c:1133: `VGA_CRTC_V_SYNC_END' undeclared (first 
use in thi
s function)
drivers/video/clgenfb.c:1133: (Each undeclared identifier is reported 
only once
drivers/video/clgenfb.c:1133: for each function it appears in.)
drivers/video/clgenfb.c:1137: `VGA_CRTC_H_TOTAL' undeclared (first use 
in this f
unction)
drivers/video/clgenfb.c:1140: `VGA_CRTC_H_DISP' undeclared (first use in 
this fu
nction)
drivers/video/clgenfb.c:1143: `VGA_CRTC_H_BLANK_START' undeclared (first 
use in
this function)
drivers/video/clgenfb.c:1146: `VGA_CRTC_H_BLANK_END' undeclared (first 
use in th
is function)
drivers/video/clgenfb.c:1149: `VGA_CRTC_H_SYNC_START' undeclared (first 
use in t
his function)
drivers/video/clgenfb.c:1155: `VGA_CRTC_H_SYNC_END' undeclared (first 
use in thi
s function)
drivers/video/clgenfb.c:1158: `VGA_CRTC_V_TOTAL' undeclared (first use 
in this f
unction)
drivers/video/clgenfb.c:1176: `VGA_CRTC_OVERFLOW' undeclared (first use 
in this
function)
drivers/video/clgenfb.c:1184: `VGA_CRTC_MAX_SCAN' undeclared (first use 
in this
function)
drivers/video/clgenfb.c:1187: `VGA_CRTC_V_SYNC_START' undeclared (first 
use in t
his function)
drivers/video/clgenfb.c:1193: `VGA_CRTC_V_DISP_END' undeclared (first 
use in thi
s function)
drivers/video/clgenfb.c:1196: `VGA_CRTC_V_BLANK_START' undeclared (first 
use in
this function)
drivers/video/clgenfb.c:1199: `VGA_CRTC_V_BLANK_END' undeclared (first 
use in th
is function)
drivers/video/clgenfb.c:1202: `VGA_CRTC_LINE_COMPARE' undeclared (first 
use in this function)
drivers/video/clgenfb.c:1239: `VGA_CRTC_MODE' undeclared (first use in 
this func
tion)
drivers/video/clgenfb.c:1250: `VGA_CRTC_REGS' undeclared (first use in 
this func
tion)
drivers/video/clgenfb.c:1254: `VGA_SEQ_CHARACTER_MAP' undeclared (first 
use in t
his function)
drivers/video/clgenfb.c:1262: `VGA_MIS_W' undeclared (first use in this 
function
)
drivers/video/clgenfb.c:1264: `VGA_CRTC_PRESET_ROW' undeclared (first 
use in thi
s function)
drivers/video/clgenfb.c:1265: `VGA_CRTC_CURSOR_START' undeclared (first 
use in t
his function)
drivers/video/clgenfb.c:1266: `VGA_CRTC_CURSOR_END' undeclared (first 
use in thi
s function)
drivers/video/clgenfb.c:1277: warning: implicit declaration of function 
`vga_wgf
x'
drivers/video/clgenfb.c:1277: `VGA_GFX_MODE' undeclared (first use in 
this funct
ion)
drivers/video/clgenfb.c:1346: `VGA_PEL_MSK' undeclared (first use in 
this functi
on)
drivers/video/clgenfb.c:1351: `VGA_SEQ_MEMORY_MODE' undeclared (first 
use in thi
s function)
drivers/video/clgenfb.c:1352: `VGA_SEQ_PLANE_WRITE' undeclared (first 
use in thi
s function)
drivers/video/clgenfb.c:1599: `VGA_CRTC_OFFSET' undeclared (first use in 
this fu
nction)
drivers/video/clgenfb.c:1612: `VGA_CRTC_CURSOR_HI' undeclared (first use 
in this
  function)
drivers/video/clgenfb.c:1613: `VGA_CRTC_CURSOR_LO' undeclared (first use 
in this
  function)
drivers/video/clgenfb.c:1614: `VGA_CRTC_UNDERLINE' undeclared (first use 
in this
  function)
drivers/video/clgenfb.c:1616: warning: implicit declaration of function 
`vga_wat
tr'
drivers/video/clgenfb.c:1616: `VGA_ATC_MODE' undeclared (first use in 
this funct
ion)
drivers/video/clgenfb.c:1617: `VGA_ATC_OVERSCAN' undeclared (first use 
in this f
unction)
drivers/video/clgenfb.c:1618: `VGA_ATC_PLANE_ENABLE' undeclared (first 
use in th
is function)
drivers/video/clgenfb.c:1620: `VGA_ATC_COLOR_PAGE' undeclared (first use 
in this
  function)
drivers/video/clgenfb.c:1626: `VGA_GFX_SR_VALUE' undeclared (first use 
in this f
unction)
drivers/video/clgenfb.c:1627: `VGA_GFX_SR_ENABLE' undeclared (first use 
in this
function)
drivers/video/clgenfb.c:1628: `VGA_GFX_COMPARE_VALUE' undeclared (first 
use in t
his function)
drivers/video/clgenfb.c:1629: `VGA_GFX_DATA_ROTATE' undeclared (first 
use in thi
s function)
drivers/video/clgenfb.c:1630: `VGA_GFX_PLANE_READ' undeclared (first use 
in this
  function)
drivers/video/clgenfb.c:1631: `VGA_GFX_MISC' undeclared (first use in 
this funct
ion)
drivers/video/clgenfb.c:1632: `VGA_GFX_COMPARE_MASK' undeclared (first 
use in th
is function)
drivers/video/clgenfb.c:1633: `VGA_GFX_BIT_MASK' undeclared (first use 
in this f
unction)
drivers/video/clgenfb.c:1646: `VGA_SEQ_CLOCK_MODE' undeclared (first use 
in this
  function)
drivers/video/clgenfb.c: In function `clgen_pan_display':
drivers/video/clgenfb.c:1797: `VGA_CRTC_START_LO' undeclared (first use 
in this
function)
drivers/video/clgenfb.c:1798: `VGA_CRTC_START_HI' undeclared (first use 
in this
function)
drivers/video/clgenfb.c:1808: warning: implicit declaration of function 
`vga_rcr
t'
drivers/video/clgenfb.c: In function `clgen_blank':
drivers/video/clgenfb.c:1858: `VGA_SEQ_CLOCK_MODE' undeclared (first use 
in this
  function)
drivers/video/clgenfb.c: In function `init_vgachip':
drivers/video/clgenfb.c:1970: `VGA_SEQ_CLOCK_MODE' undeclared (first use 
in this
  function)
drivers/video/clgenfb.c:1971: `VGA_MIS_W' undeclared (first use in this 
function
)
drivers/video/clgenfb.c:1993: `VGA_SEQ_PLANE_WRITE' undeclared (first 
use in thi
s function)
drivers/video/clgenfb.c:1994: `VGA_SEQ_CHARACTER_MAP' undeclared (first 
use in t
his function)
drivers/video/clgenfb.c:1995: `VGA_SEQ_MEMORY_MODE' undeclared (first 
use in thi
s function)
drivers/video/clgenfb.c:2018: `VGA_CRTC_PRESET_ROW' undeclared (first 
use in thi
s function)
drivers/video/clgenfb.c:2019: `VGA_CRTC_CURSOR_START' undeclared (first 
use in t
his function)
drivers/video/clgenfb.c:2020: `VGA_CRTC_CURSOR_END' undeclared (first 
use in thi
s function)
drivers/video/clgenfb.c:2021: `VGA_CRTC_START_HI' undeclared (first use 
in this
function)
drivers/video/clgenfb.c:2022: `VGA_CRTC_START_LO' undeclared (first use 
in this
function)
drivers/video/clgenfb.c:2023: `VGA_CRTC_CURSOR_HI' undeclared (first use 
in this
  function)
drivers/video/clgenfb.c:2024: `VGA_CRTC_CURSOR_LO' undeclared (first use 
in this
  function)
drivers/video/clgenfb.c:2026: `VGA_CRTC_UNDERLINE' undeclared (first use 
in this
  function)
drivers/video/clgenfb.c:2027: `VGA_CRTC_MODE' undeclared (first use in 
this func
tion)
drivers/video/clgenfb.c:2028: `VGA_CRTC_LINE_COMPARE' undeclared (first 
use in t
his function)
drivers/video/clgenfb.c:2032: `VGA_GFX_SR_VALUE' undeclared (first use 
in this f
unction)
drivers/video/clgenfb.c:2033: `VGA_GFX_SR_ENABLE' undeclared (first use 
in this
function)
drivers/video/clgenfb.c:2034: `VGA_GFX_COMPARE_VALUE' undeclared (first 
use in t
his function)
drivers/video/clgenfb.c:2035: `VGA_GFX_DATA_ROTATE' undeclared (first 
use in thi
s function)
drivers/video/clgenfb.c:2036: `VGA_GFX_PLANE_READ' undeclared (first use 
in this
  function)
drivers/video/clgenfb.c:2037: `VGA_GFX_MODE' undeclared (first use in 
this funct
ion)
drivers/video/clgenfb.c:2038: `VGA_GFX_MISC' undeclared (first use in 
this funct
ion)
drivers/video/clgenfb.c:2039: `VGA_GFX_COMPARE_MASK' undeclared (first 
use in th
is function)
drivers/video/clgenfb.c:2040: `VGA_GFX_BIT_MASK' undeclared (first use 
in this f
unction)
drivers/video/clgenfb.c:2052: `VGA_ATC_PALETTE0' undeclared (first use 
in this f
unction)
drivers/video/clgenfb.c:2053: `VGA_ATC_PALETTE1' undeclared (first use 
in this f
unction)
drivers/video/clgenfb.c:2054: `VGA_ATC_PALETTE2' undeclared (first use 
in this f
unction)
drivers/video/clgenfb.c:2055: `VGA_ATC_PALETTE3' undeclared (first use 
in this f
unction)
drivers/video/clgenfb.c:2056: `VGA_ATC_PALETTE4' undeclared (first use 
in this function)
drivers/video/clgenfb.c:2057: `VGA_ATC_PALETTE5' undeclared (first use 
in this f
unction)
drivers/video/clgenfb.c:2058: `VGA_ATC_PALETTE6' undeclared (first use 
in this f
unction)
drivers/video/clgenfb.c:2059: `VGA_ATC_PALETTE7' undeclared (first use 
in this f
unction)
drivers/video/clgenfb.c:2060: `VGA_ATC_PALETTE8' undeclared (first use 
in this f
unction)
drivers/video/clgenfb.c:2061: `VGA_ATC_PALETTE9' undeclared (first use 
in this f
unction)
drivers/video/clgenfb.c:2062: `VGA_ATC_PALETTEA' undeclared (first use 
in this f
unction)
drivers/video/clgenfb.c:2063: `VGA_ATC_PALETTEB' undeclared (first use 
in this f
unction)
drivers/video/clgenfb.c:2064: `VGA_ATC_PALETTEC' undeclared (first use 
in this f
unction)
drivers/video/clgenfb.c:2065: `VGA_ATC_PALETTED' undeclared (first use 
in this f
unction)
drivers/video/clgenfb.c:2066: `VGA_ATC_PALETTEE' undeclared (first use 
in this f
unction)
drivers/video/clgenfb.c:2067: `VGA_ATC_PALETTEF' undeclared (first use 
in this f
unction)
drivers/video/clgenfb.c:2069: `VGA_ATC_MODE' undeclared (first use in 
this funct
ion)
drivers/video/clgenfb.c:2070: `VGA_ATC_OVERSCAN' undeclared (first use 
in this f
unction)
drivers/video/clgenfb.c:2071: `VGA_ATC_PLANE_ENABLE' undeclared (first 
use in th
is function)
drivers/video/clgenfb.c:2073: `VGA_ATC_COLOR_PAGE' undeclared (first use 
in this
  function)
drivers/video/clgenfb.c:2075: `VGA_PEL_MSK' undeclared (first use in 
this functi
on)
drivers/video/clgenfb.c: In function `clgen_set_disp':
drivers/video/clgenfb.c:2185: dereferencing pointer to incomplete type
drivers/video/clgenfb.c:2242: dereferencing pointer to incomplete type
drivers/video/clgenfb.c:2242: `fbcon_dummy' undeclared (first use in 
this functi
on)
drivers/video/clgenfb.c:2243: dereferencing pointer to incomplete type
drivers/video/clgenfb.c: In function `clgen_pci_setup':
drivers/video/clgenfb.c:2543: warning: implicit declaration of function 
`pcibios
_write_config_dword'
drivers/video/clgenfb.c: In function `clgenfb_init':
drivers/video/clgenfb.c:2789: `fbgen_switch' undeclared (first use in 
this funct
ion)
drivers/video/clgenfb.c:2790: `fbgen_update_var' undeclared (first use 
in this f
unction)
drivers/video/clgenfb.c:2811: warning: implicit declaration of function 
`fbgen_d
o_set_var'
drivers/video/clgenfb.c:2818: invalid use of undefined type `struct display'
drivers/video/clgenfb.c:2819: warning: implicit declaration of function 
`fbgen_s
et_disp'
drivers/video/clgenfb.c:2820: warning: implicit declaration of function 
`do_inst
all_cmap'
drivers/video/clgenfb.c: In function `WGen':
drivers/video/clgenfb.c:2923: `VGA_PEL_IR' undeclared (first use in this 
functio
n)
drivers/video/clgenfb.c:2923: `VGA_PEL_D' undeclared (first use in this 
function
)
drivers/video/clgenfb.c:2927: warning: implicit declaration of function 
`vga_w'
drivers/video/clgenfb.c: In function `RGen':
drivers/video/clgenfb.c:2938: `VGA_PEL_IR' undeclared (first use in this 
functio
n)
drivers/video/clgenfb.c:2938: `VGA_PEL_D' undeclared (first use in this 
function
)
drivers/video/clgenfb.c:2942: warning: implicit declaration of function 
`vga_r'
drivers/video/clgenfb.c: In function `AttrOn':
drivers/video/clgenfb.c:2955: `VGA_ATT_IW' undeclared (first use in this 
functio
n)
drivers/video/clgenfb.c:2956: `VGA_ATT_R' undeclared (first use in this 
function
)
drivers/video/clgenfb.c: In function `WHDR':
drivers/video/clgenfb.c:2981: `VGA_PEL_MSK' undeclared (first use in 
this functi
on)
drivers/video/clgenfb.c:2984: `VGA_PEL_IW' undeclared (first use in this 
functio
n)
drivers/video/clgenfb.c: In function `WClut':
drivers/video/clgenfb.c:3041: `VGA_PEL_D' undeclared (first use in this 
function
)
drivers/video/clgenfb.c:3044: `VGA_PEL_IW' undeclared (first use in this 
functio
n)
drivers/video/clgenfb.c: In function `clgen_WaitBLT':
drivers/video/clgenfb.c:3097: warning: implicit declaration of function 
`vga_rgf
x'
drivers/video/clgenfb.c: In function `clgen_RectFill':
drivers/video/clgenfb.c:3240: `VGA_GFX_SR_VALUE' undeclared (first use 
in this function)
drivers/video/clgenfb.c:3241: `VGA_GFX_SR_ENABLE' undeclared (first use 
in this
function)
drivers/video/clgenfb.c: At top level:
drivers/video/clgenfb.c:412: storage size of `disp' isn't known
drivers/video/clgenfb.c:3109: warning: `clgen_BitBLT' defined but not used
drivers/video/clgenfb.c:3200: warning: `clgen_RectFill' defined but not used
make[2]: *** [drivers/video/clgenfb.o] Error 1
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2




