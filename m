Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbTFPFdR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 01:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbTFPFdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 01:33:17 -0400
Received: from bunyip.cc.uq.edu.au ([130.102.2.1]:22279 "EHLO
	bunyip.cc.uq.edu.au") by vger.kernel.org with ESMTP id S263355AbTFPFdQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 01:33:16 -0400
Message-ID: <3EED59BA.8040104@torque.net>
Date: Mon, 16 Jun 2003 15:46:34 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, centaur@netmagic.net
Subject: Re: PROBLEM: 2.4.21 crashes hard running cdrecord in X.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Per Nystrom wrote:
 > Alright, I've really gotten it narrowed down now.
 >
 > The hard crash occurs only when magicdev is running.  I tried turning
 > off all my preferences for auto- mounting, running, and playing
 > data/audio cds in my preferences, and voila!  cdrecord works without a
 > hiccup in X too.

Per,
Interesting. My SCSI Yamaha 4416 burner also doesn't like magicdev
running during a burn by cdrecord. The effect is to lock up
burner (not the whole system). Since a device lockup leads
to an attempted device reset (and the latter is quite fragile
in the ide-scsi driver), my guess is that my Yamaha and your
Sony writer have the same firmware weakness.

Magicdev sends out a Test Unit Ready command every few seconds
and it seems some burners can't handle this while burning (or
in the final fixate stage). The simple solution is to turn off
magicdev (then your system will no longer detect CDROMs being
placed in the drive).

Doug Gilbert

