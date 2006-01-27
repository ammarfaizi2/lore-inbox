Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbWA0SEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWA0SEo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 13:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWA0SEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 13:04:44 -0500
Received: from uproxy.gmail.com ([66.249.92.200]:47535 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751074AbWA0SEo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 13:04:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s9mVeThDUoaieCp//EiUSH9an/6CgHK8r16FYMWthCFgi0idf/HOBCESEhvlBDL0fsx6tYFSfZmXccWnXmk/mSb//V6ZpcyCXiaSjajh3ToevCeTx+0vOgmg9Hpt3oDhF1Ij3dAFrLeRvaj30Em+q9+1v574gnWvsaRGwBt1SDo=
Message-ID: <40f323d00601271004h7d6e3de3r1abc531cabc30b21@mail.gmail.com>
Date: Fri, 27 Jan 2006 19:04:42 +0100
From: Benoit Boissinot <bboissin@gmail.com>
To: Andy Spiegl <kernelbug.Andy@spiegl.de>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Benoit Boissinot <bboissin@gmail.com>, John Stoffel <john@stoffel.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.15 crashes X Server after running OpenGL programs
In-Reply-To: <20060127173215.GC19166@spiegl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060124121542.GB13646@spiegl.de>
	 <20060124142151.GA3538@spiegl.de>
	 <40f323d00601240713x26c3a04cra46e1cd9639b12f2@mail.gmail.com>
	 <200601241937.06679.s0348365@sms.ed.ac.uk>
	 <20060127173215.GC19166@spiegl.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/06, Andy Spiegl <kernelbug.Andy@spiegl.de> wrote:
> Maybe I am doing something wrong but Mesa is awfully slow.
> I don't need highend acceleration but I can't even play tuxracer.
>
> Maybe I missed something???
>
> gl-info says:
>  GL_VENDOR = "Mesa project: www.mesa3d.org"
>  GL_RENDERER = "Mesa GLX Indirect"
>  GL_VERSION = "1.3 Mesa 4.0.4"
>  GL_EXTENSIONS = "GL_ARB_imaging GL_ARB_multitexture GL_ARB_texture_border_clamp GL_ARB_texture_cube_map GL_ARB_texture_env_add GL_ARB_texture_env_combine GL_ARB_texture_env_dot3 GL_ARB_transpose_matrix GL_EXT_abgr GL_EXT_blend_color GL_EXT_blend_minmax GL_EXT_blend_subtract GL_EXT_texture_env_add GL_EXT_texture_env_combine GL_EXT_texture_env_dot3 GL_EXT_texture_lod_bias "
>
You should be looking for
"direct rendering: Yes"
in glxinfo

You can check your X logs to see why you don't get the acceleration
(and you have to compile drm/radeon in your kernel).

regards,

Benoit
