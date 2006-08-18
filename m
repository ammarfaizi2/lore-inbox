Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbWHRRhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbWHRRhj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 13:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWHRRhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 13:37:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:33808 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751432AbWHRRhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 13:37:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ufRkeAYy9gqtTTDHwQS8tAmLpHxc7Hx1k86j6gPJH5aMbBSginze08Ef/CirPErl32sBgLovhN/Vg7opCEK+6AmYazly9QVi5R6e8NIpM7/ELg04B2qwi6Qo0I8wBiudvQCNS46ehgvCizc+X0h8GpswY636hMzgfIkDGTMx6oA=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: mplayer-users@mplayerhq.hu, linux-kernel@vger.kernel.org
Subject: mplayer + heavy io: why ionice doesn't help?
Date: Fri, 18 Aug 2006 19:37:25 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608181937.25295.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed that mplayer's video playback starts to skip
if I do some serious copying or grepping on the disk
with movie being played from.

nice helps, but does not eliminate the problem.
I guessed that this is a problem with mplayer
failing to read next portion of input data in time,
so I used Jens's ionice.c from
Documentation/block/ioprio.txt

I am using it this:

ionice -c1 -n0 -p<mplayer pid>

but so far I don't see any effect from using it.
mplayer still skips.

Does anybody have an experience in this?
--
vda
