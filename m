Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316532AbSIINmD>; Mon, 9 Sep 2002 09:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316586AbSIINmD>; Mon, 9 Sep 2002 09:42:03 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:32731 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316532AbSIINl7>; Mon, 9 Sep 2002 09:41:59 -0400
Date: Mon, 9 Sep 2002 15:46:15 +0200 (CEST)
From: Oktay Akbal <oktay.akbal@s-tec.de>
X-X-Sender: oktay@omega.s-tec.de
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: md multipath with disk missing ?
In-Reply-To: <20020909132713.GA29@marowsky-bree.de>
Message-ID: <Pine.LNX.4.44.0209091537020.12771-100000@omega.s-tec.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: OK! AntiVir MailGate Version 2.0.1.1; AVE: 6.15.0.1; VDF: 6.15.0.6
	 at email has not found any known virus in this email.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Does this only work with raid-autodetection ?
> > When no autodetection is done and a drive is missing, would a raidstart
> > kill the raid, since the drives are now available with other devices (sda
> > instead of former sdb...) ?
>
> I don't understand your question, sorry.

Example:

We have sda - sdb (8 drives) and setup up a raidtab to tell linux that
sda and sde are the same sdc - sdd etc.
Now for some random error the server restarts and the former sda (path to
that drive) is no longer available. So now we have sda,sdb...sdg.
We do not use autodetect, but raidstart to activate the raid.

now since the former sda is missing the raidtab does not reflect the
actual setup. The raidtab would read, that sda and sdb are the same
drive, which is not true in that case.

(The device-ordering would not be right for a real setup, but take it as
an example and assume sda-sde sdb-sdf...)

Would the superblock prevent the wrong use of devices ?
(With raid-configuration setup on top of multipathing ?)




Oktay Akbal
S-Tec Datenverarbeitung GmbH
Feuerbachstr. 8
68163 Mannheim
Tel: 0621-4185070
Fax: 0621-4185071

