Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267352AbTAGJhT>; Tue, 7 Jan 2003 04:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267354AbTAGJhT>; Tue, 7 Jan 2003 04:37:19 -0500
Received: from [212.71.168.94] ([212.71.168.94]:62949 "EHLO
	vagabond.cybernet.cz") by vger.kernel.org with ESMTP
	id <S267352AbTAGJhT>; Tue, 7 Jan 2003 04:37:19 -0500
Date: Tue, 7 Jan 2003 10:45:47 +0100
From: Jan Hudec <bulb@ucw.cz>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: John Bradford <john@grabjohn.com>, Max Valdez <maxvaldez@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Undelete files on ext3 ??
Message-ID: <20030107094547.GG2141@vagabond>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>,
	Maciej Soltysiak <solt@dns.toxicfilms.tv>,
	John Bradford <john@grabjohn.com>, Max Valdez <maxvaldez@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <200301070859.h078xEnI000337@darkstar.example.net> <Pine.LNX.4.44.0301071004550.30728-100000@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301071004550.30728-100000@dns.toxicfilms.tv>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2003 at 10:29:06AM +0100, Maciej Soltysiak wrote:
> > There is no simple way, no.
> What about IDE Taskfile access, it's help says something like it's the
> crown jewel of hard drive forensics.
> 
> One question, how ext2/3 deletes files? similarily to fat by renaming the
> first character?

No. By removing the directory entry completely and marking the inode
unused.

By the way, there used to be undelete tool for ext2. It created a list
of deleted inodes with correct stat, but no names, only their inode
numbers. You could then pick the corect inode and give it a name, thus
bringing it back to life. Since ext3 is just ext2 with journal, I guess
it might work. It existed as a standalone tool and integrated to
midnight commander.

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
