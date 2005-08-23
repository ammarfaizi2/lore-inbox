Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbVHWHwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbVHWHwO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 03:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbVHWHwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 03:52:14 -0400
Received: from heisenberg.zen.co.uk ([212.23.3.141]:19177 "EHLO
	heisenberg.zen.co.uk") by vger.kernel.org with ESMTP
	id S1750859AbVHWHwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 03:52:13 -0400
Message-Id: <200508230752.j7N7qCto019459@StraightRunning.com>
From: "Colin Harrison" <colin.harrison@virgin.net>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Xming build fails with latest xc/programs/Xserver/GL/glx changes
Date: Tue, 23 Aug 2005 08:52:15 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: 
X-Copyright: Copyright (c) 2005 Colin Harrison
X-Domain: StraightRunning.com
X-Admin: colin@straightrunning.com
X-Originating-Heisenberg-IP: [62.3.107.196]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wrong List
Sorry 

> -----Original Message-----
> From: Colin Harrison [mailto:colin.harrison@virgin.net] 
> Sent: 23 August 2005 08:49
> To: 'linux-kernel@vger.kernel.org'
> Subject: Xming build fails with latest 
> xc/programs/Xserver/GL/glx changes
> 
> Hi,
> 
> Following the recent changes in xc/programs/Xserver/GL/glx,
> 
> "Convert uses of __glPointParameterfvARB_size to 
> __glPointParameterfvEXT_size and uses of 
> __glPointParameteriv_size to __glPointParameterivNV_size"
> 
> The latter change to PointParameteriv and PointParameteri 
> causes Xming to stop compiling:-
> 
> /usr/local/cross-tools/i386-mingw32msvc/bin/`echo gcc|sed 
> "s%.*/%%"` -o Xming.exe -Os -march=pentium3 -mfpmath=sse 
> -ffast-math -fno-strict-aliasing -Wall -Wpointer-arith 
> -Wundef  -e _mainCRTStartup  -mwindows -L../../exports/lib   
> hw/xwin/stubs.o hw/xwin/XWin.res               dix/libdix.a 
> os/libos.a  hw/xwin/libXWin.a fb/libfb.a dix/libxpstubs.a 
> mi/libmi.a dix/libdix.a composite/libcomposite.a 
> damageext/libdamage.a miext/damage/libdamage.a 
> xfixes/libxfixes.a miext/cw/libcw.a                  
> Xext/libext.a xkb/libxkb.a os/libos.a Xi/libxinput.a          
>           dbe/libdbe.a record/librecord.a  XTrap/libxtrap.a 
> GL/glx/libglx_stdcall.a                GL/windows/libGLcore.a 
> randr/librandr.a render/librender.a hw/xwin/libXWin.a         
>     miext/shadow/libshadow.a  miext/rootless/librootless.a    
>         miext/rootless/safeAlpha/libsafeAlpha.a         
> miext/rootless/accel/librlAccel.a os/libos.a      
> ../../lib/font/libXfont.a  dix/libxpstubs.a 
> -L../../exports/lib   -lX11 -lwsock32 -lz                     
>   -lXau  -lXdmcp   -lgdi32 -lwsock32 -lopengl32 -lpthreadGC2
> GL/glx/libglx_stdcall.a(g_render.o):g_render.c:(.text+0x129f):
>  undefined reference to `_glPointParameteriNV@8'
> GL/glx/libglx_stdcall.a(g_render.o):g_render.c:(.text+0x12e7):
>  undefined reference to `_glPointParameteriNV@8'
> GL/glx/libglx_stdcall.a(g_render.o):g_render.c:(.text+0x12fa):
>  undefined reference to `_glPointParameterivNV@8'
> GL/glx/libglx_stdcall.a(g_render.o):g_render.c:(.text+0x1365):
>  undefined reference to `_glPointParameterivNV@8'
> collect2: ld returned 1 exit status
> make[4]: *** [Xming.exe] Error 1
> 
> Compiled using:-
> 
> make World 
> CROSSCOMPILEDIR=/usr/local/cross-tools/i386-mingw32msvc/bin 
> LOCAL_LDFLAGS=-mwindows
> 
> Reversion fixes the problem for me.
> Anyone got a better idea?
> 
> Colin Harrison
> 

