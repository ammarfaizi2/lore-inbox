Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264471AbRFOSRk>; Fri, 15 Jun 2001 14:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264470AbRFOSR2>; Fri, 15 Jun 2001 14:17:28 -0400
Received: from [195.211.46.202] ([195.211.46.202]:58687 "EHLO serv02.lahn.de")
	by vger.kernel.org with ESMTP id <S264467AbRFOSRJ>;
	Fri, 15 Jun 2001 14:17:09 -0400
Date: Fri, 15 Jun 2001 08:40:57 +0200 (CEST)
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Reply-To: <pmhahn@titan.lahn.de>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Zip: what does that mean?
In-Reply-To: <20010614104350.A16562@ulima.unil.ch>
Message-ID: <Pine.LNX.4.33.0106150836270.5555-100000@titan.lahn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jun 2001, Gregoire Favre wrote:

> I have an IDE 250Mb Zip, it work fine, but I can see:
>
> Jun 11 23:52:35 greg kernel: ide-floppy: hdc: I/O error, pc = 5a, key =
> 5, asc = 24, ascq =  0
> Jun 11 23:52:37 greg kernel:  hdc: unknown partition table
> Jun 11 23:52:37 greg kernel: hdc: 98304kB, 96/64/32 CHS, 4096 kBps, 512
> sector size, 2941 rpm
>
> Could someone explain me what's wrong?
Nothing. Somethings is reeding /proc/partitions which lists all known
partitions. "fdisk" or "mount" do this.

When reading the file the kernel has to check the media in your zip-drive.
Problem is, you havn't put in one. So there is no partition table to read
and the kernel complains and returns the default values of a typical
100MB zip media.

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de

