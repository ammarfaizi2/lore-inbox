Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267346AbUIJJit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267346AbUIJJit (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 05:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267343AbUIJJis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 05:38:48 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:62727 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S267353AbUIJJhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 05:37:41 -0400
Message-ID: <414176F2.3030301@hist.no>
Date: Fri, 10 Sep 2004 11:42:10 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
       William Stearns <wstearns@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: silent semantic changes in reiser4 (brief attempt to document
 the idea ofwhat reiser4 wants to do with metafiles and why
References: <41323AD8.7040103@namesys.com> <413E170F.9000204@namesys.com> <Pine.LNX.4.58.0409071658120.2985@sparrow> <200409080009.52683.robin.rosenberg.lists@dewire.com> <20040909090342.GA30303@thunk.org>
In-Reply-To: <20040909090342.GA30303@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:

>On Wed, Sep 08, 2004 at 12:09:52AM +0200, Robin Rosenberg wrote:
>  
>
>>Maybe file/./attribute then. /. on a file is currently meaningless. That does 
>>not avoid the unpleasant fact that has been brought up by others (only to be 
>>ignored), that the directory syntax does not allow metadata on directories.
>>    
>>
>
>*Not* that I am endorsing the idea of being able to access metadata
>via a standard pathname --- I continue to believe that named streams
>are a bad idea that will be an attractive nuisance to application
>developers, and if we must do them, then Solaris's openat(2) API is
>the best way to proceed --- HOWEVER, if people are insistent on being
>able to do this via standard pathnames, and not introducing a new
>system call, I would suggest /|/ as the separator as the third least
>worst option.  Why?
>  
>
What's wrong with using / as the separator?  It is already
used to separate components of pathnames.  Named streams
are very much like files in a subdirectory.

This scheme makes for very little change to existing tools,
users may then do a "gimp somefile/icon.jpg"  for example.
Or "ls somefile/*" to see all the named streams/forks.

Helge Hafting
