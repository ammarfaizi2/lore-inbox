Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030322AbWGMTfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030322AbWGMTfa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 15:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030319AbWGMTfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 15:35:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:23922 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030322AbWGMTf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 15:35:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Cglc9z4Chkd3RSq5FlLW+Igjqj/Q3x4D+O0lC+DgtVOEqrlRjsNji9er0V/mglbFb6Mc8JFJhpRFsnl2fOmFl3AhJWe61ri7p3tagGlW05AzrlF/NehwabQvIbaUzXkacauRLKQDhFF+YTFDs4VuUAtI5yNawMx1JQBhFdbHJTs=
Message-ID: <d120d5000607131235r5cc9b558xfd04a1f3118d8124@mail.gmail.com>
Date: Thu, 13 Jul 2006 15:35:27 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Roman Zippel" <zippel@linux-m68k.org>
Subject: Fwd: Using select in boolean dependents of a tristate symbol
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <d120d5000607131232i74dfdb9t1a132dfc5dd32bc4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d120d5000607131232i74dfdb9t1a132dfc5dd32bc4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Argh.. resending to correct LKML address]

Roman,

Question for you as Kconfig maintainer - I have a module (HID) that
has a few sub-options. Now HID can be built as a module but
sub-options are suimple booleans. Some of these sub-options will
depend on a common code which is moved out of HID driver. Now I want
to use "select" like this:

 config THRUSTMASTER_FF
       bool "ThrustMaster FireStorm Dual Power 2 support (EXPERIMENTAL)"
       depends on HID_FF && EXPERIMENTAL
+       select INPUT_FF_MEMLESS
       help
         Say Y here if you have a THRUSTMASTER FireStore Dual Power 2,
         and want to enable force feedback support for it.

Unfortunately this forces INPUT_FF_MEMLESS to always be built-in,
although if HID is a module it could be a module as well. Do you have
any suggestions as to how allow INPUT_FF_MEMLESS to be compiled as a
module?

Thanks!

--
Dmitry


-- 
Dmitry
