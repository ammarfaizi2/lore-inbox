Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751558AbWB0Une@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbWB0Une (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 15:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWB0Une
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 15:43:34 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:42922 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S1751541AbWB0Und
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 15:43:33 -0500
Message-ID: <44036470.8050305@namesys.com>
Date: Mon, 27 Feb 2006 12:43:28 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: creating live virtual files by concatenation
References: <1271316508.20060225153749@dns.toxicfilms.tv> <9a8748490602250735l6161a96dte2805b772a89a436@mail.gmail.com> <612760535.20060225181521@dns.toxicfilms.tv> <Pine.LNX.4.63.0602251339320.13659@cuia.boston.redhat.com> <9a8748490602251052p3e56334ei755c9ce2100e03c@mail.gmail.com> <1391154345.20060225203352@dns.toxicfilms.tv> <4400DA93.9080901@st-andrews.ac.uk> <Pine.LNX.4.63.0602251736340.13659@cuia.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.63.0602251736340.13659@cuia.boston.redhat.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

>On Sat, 25 Feb 2006, Peter Foldiak wrote:
>
>  
>
>>"sub-file" corresponding to a key-range. Writing a chapter should change the
>>book that the chapter is part of. That is what would make it really valuable.
>>Of course it would have all sorts of implications (e.g. for metadata for each
>>part) that need to be thought about, but it could be done properly, I think.
>>    
>>
>
>What happens if you read the first 10kB of a file,
>and one of the "chapters" behind your read cursor
>grows?
>  
>
That is why you have magic delimiters, like the colons and newlines in
/etc/passwd.  You also specify the delimiters in your inheritance
syntax.  You don't want it to really all be one file, because you want
separation of modification times and acls that let users change their
own gecos field and etc., but there are times when you want to act on
/etc/passwd as one file.

>Do you read part of the same data again when you
>continue reading?
>
>Does the read cursor automatically advance?
>
>Your idea changes the way userspace expects files
>to behave...
>
>  
>

