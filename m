Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbUC0TKZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 14:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbUC0TKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 14:10:25 -0500
Received: from vvv.conterra.de ([212.124.44.162]:19332 "EHLO conterra.de")
	by vger.kernel.org with ESMTP id S261851AbUC0TKY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 14:10:24 -0500
Message-ID: <4065D19A.1040903@conterra.de>
Date: Sat, 27 Mar 2004 20:10:18 +0100
From: Dieter Stueken <stueken@conterra.de>
Organization: con terra GmbH
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: nfsd oops with 2.6.5-rc2-mm4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank wrote:
> I got a reproducible oops after a few minutes with a 2.6.5-rc2-mm4 kernel.
> ...
> [<c01e6a8d>] nfsd_readdir+0x69/0xe8

was some exported directory quite big? Try running a "find /mnt/..." on
the client to see when exactly it fails. I observe similar behavior
when reading huge directories of some 1000 entries. What nfs version
are you using? You may try "mount -o nfsvers=2 ..." or 3.

My own Oops seems to be reproducible when using a Sun (2.8) as
client, only. It did not occur when using nfsV2. I also failed
to reproduce the bug when mounting by an other Linux client.
So may be we observe two different bugs here.

With that instability observed, I won't/can't switch to 2.6.x for
my system in production :-( Can I help somehow? Making a TCP-dump?
Try some patches?

Dieter.
-- 
Dieter Stüken, con terra GmbH, Münster
     stueken@conterra.de
     http://www.conterra.de/
     (0)251-7474-501

