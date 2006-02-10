Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWBJPOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWBJPOA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 10:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWBJPOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 10:14:00 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:916 "EHLO
	zcars04f.nortel.com") by vger.kernel.org with ESMTP id S932129AbWBJPN7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 10:13:59 -0500
Message-ID: <43ECADA8.9030609@nortel.com>
Date: Fri, 10 Feb 2006 09:13:44 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
CC: tytso@mit.edu, peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr> <43EB7BBA.nailIFG412CGY@burner> <mj+md-20060209.173519.1949.atrey@ucw.cz> <43EC71FB.nailISD31LRCB@burner> <20060210114721.GB20093@merlin.emma.line.org> <43EC887B.nailISDGC9CP5@burner> <mj+md-20060210.123726.23341.atrey@ucw.cz> <43EC8E18.nailISDJTQDBG@burner> <Pine.LNX.4.61.0602101409320.31246@yvahk01.tjqt.qr> <43EC93A2.nailJEB1AMIE6@burner> <20060210141651.GB18707@thunk.org> <43ECA3FC.nailJGC110XNX@burner> <43ECA70C.8050906@nortel.com> <43ECA8BC.nailJHD157VRM@burner>
In-Reply-To: <43ECA8BC.nailJHD157VRM@burner>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Feb 2006 15:13:47.0017 (UTC) FILETIME=[96E21F90:01C62E54]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:
> "Christopher Friesen" <cfriesen@nortel.com> wrote:

>>There's nothing there that says the mapping cannot change with 
>>time...just that it has to be unique.
> 
> 
> If it changes over the runtime of a program, it is not unique from the
> view of that program.

That depends on what "uniquely identified" actually means.

One possible definition is that at any time, a particular path maps to a 
single unique st_ino/st_dev tuple.

The other possibility (and this is what you seem to be advocating) is 
that a st_ino/st_dev tuple always maps to the same file over the entire 
runtime of the system.

This second possibility seems easily disproved.  If you delete and 
recreate files on a filesystem (assuming nobody has open files in the 
filesystem), at some point a new file will end up with the same inode as 
an old (deleted) file.  The two files are different, but have the same 
st_ino/st_dev tuple.

This leaves the first possibility as the only choice...

Chris
