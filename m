Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268117AbTCFODA>; Thu, 6 Mar 2003 09:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268123AbTCFODA>; Thu, 6 Mar 2003 09:03:00 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:38310
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268117AbTCFOC7>; Thu, 6 Mar 2003 09:02:59 -0500
Subject: Re: [PATCH]  fix undefined reference for sis drm.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Geoffrey Lee <glee@gnupilgrims.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@rustcorp.com.au
In-Reply-To: <20030306101017.GA6479@anakin.wychk.org>
References: <20030306101017.GA6479@anakin.wychk.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046963902.17715.37.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 06 Mar 2003 15:18:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 10:10, Geoffrey Lee wrote:
> Hi all,
> 
> 
> This fixes a bug where where if sis fb is not set and sis drm is
> selected then there will be undefined references to sis_malloc() and
> sis_free().
> 
> What I've done is a sort of a bandaid because I don't have hardware
> to fix and test. 

Direct render occurs before the frame buffer so it doesn't work
In addition you can have both modular so you'd want to make it

dep_tristate '   SiS' CONFIG_DRM_SIS $CONFIG_AGP $CONFIG_FB_SIS

even if the order worked out.
