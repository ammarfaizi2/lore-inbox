Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266852AbTAUJ2n>; Tue, 21 Jan 2003 04:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266961AbTAUJ2n>; Tue, 21 Jan 2003 04:28:43 -0500
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:51422 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S266852AbTAUJ2m> convert rfc822-to-8bit;
	Tue, 21 Jan 2003 04:28:42 -0500
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: IDE TCQ progress?
Date: Tue, 21 Jan 2003 10:37:40 +0100
User-Agent: KMail/1.4.1
References: <Pine.LNX.4.44.0301201907370.8486-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.44.0301201907370.8486-100000@coffee.psychology.mcmaster.ca>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301211037.40872.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> is it safe to assume you have TCQ-able drives?  last time I asked
> the maintainer, there were only a few WD Caviar's that did it.

As specified in the config docs

        bool "ATA tagged command queueing (EXPERIMENTAL)"
        depends on BLK_DEV_IDEDMA_PCI && EXPERIMENTAL
        help
          Support for tagged command queueing on ATA disk drives. This enables
          the IDE layer to have multiple in-flight requests on hardware that
          supports it. For now this includes the IBM Deskstar series drives,
          such as the 22GXP, 75GXP, 40GV, 60GXP, and 120GXP (ie any Deskstar 
made
          in the last couple of years), and at least some of the Western
          Digital drives in the Expert series (by nature of really being IBM
          drives).

          If you have such a drive, say Y here.

I've got an IBM 120GXP (IC35L060AVVA07-0)

> second, what were you expecting?  the kernel already schedules the head,
> so the only time it should matter is if you're doing a lot of writes
> in a particular sequence of block addresses in the same cylinder.

I expected the kernel to be somehow stable. Not too much more.

I have heard, however, that TCQ'll help a lot if connecting > 1 unit to the 
same IDE bus. Is this true?

roy
-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

