Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWBYWax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWBYWax (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 17:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWBYWax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 17:30:53 -0500
Received: from smtp.e7even.com ([83.151.192.19]:48555 "HELO smtp.e7even.com")
	by vger.kernel.org with SMTP id S932132AbWBYWax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 17:30:53 -0500
Message-ID: <4400DA93.9080901@st-andrews.ac.uk>
Date: Sat, 25 Feb 2006 22:30:43 +0000
From: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
CC: Jesper Juhl <jesper.juhl@gmail.com>, Rik van Riel <riel@redhat.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com, Hans Reiser <reiser@namesys.com>
Subject: Re: creating live virtual files by concatenation
References: <1271316508.20060225153749@dns.toxicfilms.tv> <9a8748490602250735l6161a96dte2805b772a89a436@mail.gmail.com> <612760535.20060225181521@dns.toxicfilms.tv> <Pine.LNX.4.63.0602251339320.13659@cuia.boston.redhat.com> <9a8748490602251052p3e56334ei755c9ce2100e03c@mail.gmail.com> <1391154345.20060225203352@dns.toxicfilms.tv>
In-Reply-To: <1391154345.20060225203352@dns.toxicfilms.tv>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Soltysiak wrote:

>>I can imagine quite a mess if I open a file that is really a view of
>>several files and then start manipulating text in it across "actual
>>file" boundaries  that could blow up easily.
>>    
>>
>Well, I meant that file to be read-only. Just a quick concatentated view
>for reading.
>  
>
The quick hack might be useful in certain situations. But the really 
interesting way to do it would be not to distinguish beween "actual" and 
"non-actual" files. All of them should be equally "actual", it is just 
that containment (possibly even overlap) would be allowed. The tree 
structure used by a file system such as Reiser4 would make this very 
efficient with each "sub-file" corresponding to a key-range. Writing a 
chapter should change the book that the chapter is part of. That is what 
would make it really valuable. Of course it would have all sorts of 
implications (e.g. for metadata for each part) that need to be thought 
about, but it could be done properly, I think.   Peter
