Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263339AbTJBNOu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 09:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263340AbTJBNOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 09:14:50 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:63751 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263339AbTJBNOs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 09:14:48 -0400
Message-ID: <3F7C26E0.4040106@aitel.hist.no>
Date: Thu, 02 Oct 2003 15:23:44 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: davej@codemonkey.org.uk, dri-devel@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org
Subject: dri hangs the pc (radeon 7000/VE, SiS645DX  AGP)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to get 3D graphichs, enabling the following
kernel config options:
CONFIG_AGP, CONFIG_AGP_SIS, CONFIG_DRM, CONFIG_DRM_RADEON
I'm also using the radeon framebuffer driver and
X with the appropriate driver.

Unfortunately, any attempt to use 3D, such as glxgears,
hangs the machine immediately.  The mouse cursor stops
and the keyboard is only useful for sysrq+B. (The
other sysrq keys do nothing.)

Is this an unsupported hw combination, or am I doing something
wrong?  I use "debian testing" and got opengl running
on another machine with similiar software but a Intel BX chipset
and a matrox G550.

Helge Hafting

lspci output:
00:00.0 Host bridge: Silicon Integrated Systems [SiS] SiS645DX Host & 
Memory & AGP Controller
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual 
PCI-to-PCI bridge (AGP)
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 04)
00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] 
SiS7012 PCI Audio Accelerator (rev a0)
00:03.0 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB 
Controller (rev 0f)
00:03.1 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB 
Controller (rev 0f)
00:03.2 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB 
Controller (rev 0f)
00:03.3 USB Controller: Silicon Integrated Systems [SiS] SiS7002 USB 2.0
00:0b.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] 
(rev 78)
00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY 
[Radeon 7000/VE]


glxinfo output:

name of display: :0.0
display: :0  screen: 0
direct rendering: Yes
server glx vendor string: SGI
server glx version string: 1.2
server glx extensions:
     GLX_EXT_visual_info, GLX_EXT_visual_rating, GLX_EXT_import_context
client glx vendor string: SGI
client glx version string: 1.2
client glx extensions:
     GLX_EXT_visual_info, GLX_EXT_visual_rating, GLX_EXT_import_context
GLX extensions:
     GLX_EXT_visual_info, GLX_EXT_visual_rating, GLX_EXT_import_context
OpenGL vendor string: VA Linux Systems, Inc.
OpenGL renderer string: Mesa DRI Radeon 20010402 AGP 1x x86/MMX
OpenGL version string: 1.2 Mesa 3.4.2
OpenGL extensions:
     GL_ARB_multitexture, GL_ARB_transpose_matrix, GL_EXT_abgr,
     GL_EXT_blend_func_separate, GL_EXT_clip_volume_hint,
     GL_EXT_compiled_vertex_array, GL_EXT_histogram, GL_EXT_packed_pixels,
     GL_EXT_polygon_offset, GL_EXT_rescale_normal, GL_EXT_stencil_wrap,
     GL_EXT_texture3D, GL_EXT_texture_env_add, GL_EXT_texture_env_combine,
     GL_EXT_texture_env_dot3, GL_EXT_texture_object, 
GL_EXT_texture_lod_bias,
     GL_EXT_vertex_array, GL_MESA_window_pos, GL_MESA_resize_buffers,
     GL_NV_texgen_reflection, GL_PGI_misc_hints, GL_SGIS_pixel_texture,
     GL_SGIS_texture_edge_clamp
glu version: 1.3
glu extensions:
     GLU_EXT_nurbs_tessellator, GLU_EXT_object_space_tess

    visual  x  bf lv rg d st colorbuffer ax dp st accumbuffer  ms  cav
  id dep cl sp sz l  ci b ro  r  g  b  a bf th cl  r  g  b  a ns b eat
----------------------------------------------------------------------
0x23 24 tc  0 24  0 r  y  .  8  8  8  8  0 24  0  0  0  0  0  0 0 None
0x24 24 tc  0 24  0 r  y  .  8  8  8  8  0 24  8  0  0  0  0  0 0 Slow
0x25 24 tc  0 24  0 r  y  .  8  8  8  8  0 24  0 16 16 16 16  0 0 Slow
0x26 24 tc  0 24  0 r  y  .  8  8  8  8  0 24  8 16 16 16 16  0 0 Slow
0x27 24 dc  0 24  0 r  y  .  8  8  8  8  0 24  0  0  0  0  0  0 0 None
0x28 24 dc  0 24  0 r  y  .  8  8  8  8  0 24  8  0  0  0  0  0 0 Slow
0x29 24 dc  0 24  0 r  y  .  8  8  8  8  0 24  0 16 16 16 16  0 0 Slow
0x2a 24 dc  0 24  0 r  y  .  8  8  8  8  0 24  8 16 16 16 16  0 0 Slow

