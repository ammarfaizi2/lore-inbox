Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133024AbRDZBIy>; Wed, 25 Apr 2001 21:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133025AbRDZBIn>; Wed, 25 Apr 2001 21:08:43 -0400
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:38646 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S133024AbRDZBId>; Wed, 25 Apr 2001 21:08:33 -0400
Message-ID: <3AE77560.1202CF95@kegel.com>
Date: Wed, 25 Apr 2001 18:09:52 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: hahn@coffee.psychology.mcmaster.ca,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: /proc format (was Device Registry (DevReg) Patch 0.2.0)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:
> the main goal at this point is to make kernel proc-related 
> code more efficient, easy-to-use, etc. a purely secondary goal 
> is to make user-space tools more robust, efficient, and simpler. 
> 
> there are three things that need to be communicated through the proc 
> interface, for each chunk of data: its type, it's name and its value. 
> it's critical that data be tagged in some way, since that's the only 
> way to permit back-compatibility. that is, a tool looking for a particular 
> tag will naturally ignore new data with other tags. 

Agreed.

> [three example schemes in use in /proc today]
> I have a sense that all of these could be collapsed into a single 
> api where kernel systems would register hierarchies of tuples of 
> <type,tag,callback>, where callback would be passed the tag, 
> and proc code would take care of "rendering" the data into 
> human readable text (default), binary, or even xml. 

Sounds reasonable to me.  Relieve the modules of having to
format their /proc entries by defining standard code that does
it.   And as an extra bonus, if tuples registration was table-driven,
the tables would define a grammar that could be fed to a parser
generator.

(It sounds a little bit like the snmpd code I'm working on,
actually.  How eerie.)

(It also sounds a little like (gasp) the windows registry,
but hey, that's ok.)

- Dan
