Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312558AbSGFRH7>; Sat, 6 Jul 2002 13:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315628AbSGFRH6>; Sat, 6 Jul 2002 13:07:58 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:14452 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S312558AbSGFRH6>; Sat, 6 Jul 2002 13:07:58 -0400
Date: Sat, 6 Jul 2002 11:10:33 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: inline generic_writepages(mapping,nr_to_write)?
Message-ID: <Pine.LNX.4.44.0207061104130.10105-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(I keep forgetting whom to send mm suggestions, however this is a question
for all of you.)

Now that generic_writepages() shrinked a lot, couldn't we consider making 
it inline?

inline int generic_writepages(struct address_space *mapping,
			      int nr_to_write)
{
	return mpage_writepages(mapping, nr_to_write, NULL);
}

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------


