Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264139AbTEaE2I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 00:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264143AbTEaE2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 00:28:08 -0400
Received: from main.gmane.org ([80.91.224.249]:944 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264139AbTEaE2H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 00:28:07 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
Subject: Re: local apic timer ints not working with vmware: nolocalapic
Date: Sat, 31 May 2003 00:41:26 -0400
Message-ID: <pan.2003.05.31.04.41.25.903565@interlinx.bc.ca>
References: <2C8EEAE5E5C@vcnet.vc.cvut.cz> <20030528173432.GA21379@linux.interlinx.bc.ca> <Pine.LNX.4.50.0305281341160.1982-100000@montezuma.mastecende.com> <pan.2003.05.30.22.14.35.511205@interlinx.bc.ca> <Pine.LNX.4.50.0305301907230.29718-100000@montezuma.mastecende.com> <pan.2003.05.31.03.38.16.701826@interlinx.bc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@main.gmane.org
User-Agent: Pan/0.14.0 (I'm Being Nibbled to Death by Cats!)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 May 2003 23:38:16 -0400, Brian J. Murrell wrote:
> 
> I will take another stab at all of this tomorrow to double-verify what I
> am saying here regarding the use of local APIC timer interrupts even if
> the local apic usage flag is set to disable (dont_enable_local_apic = 1).

Just to confirm now, I have modified Zwane's patch add another kernel arg,
[no]locapictimer, which deals with dont_use_local_apic_timer in the same
way his patch deals with the dont_enable_local_apic flag, and indeed, a
kernel booted with "nolapic" does hang in the APIC timer calibration
however a kernel booted with "nolocapictimer" does not.

Is it really valid to go and try to calibrate the APIC timer if it was
disabled by the user, or even DMI?

b.


