Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030359AbVJEUFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030359AbVJEUFj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 16:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030358AbVJEUFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 16:05:39 -0400
Received: from 10.ctyme.com ([69.50.231.10]:45984 "EHLO newton.ctyme.com")
	by vger.kernel.org with ESMTP id S1030359AbVJEUFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 16:05:38 -0400
Message-ID: <4344320A.7090007@perkel.com>
Date: Wed, 05 Oct 2005 13:05:30 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.10) Gecko/20050716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: Florin Malita <fmalita@gmail.com>, nix@esperi.org.uk, 7eggert@gmx.de,
       lkcl@lkcl.net, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it> <E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix> <4343E611.1000901@perkel.com> <20051005144441.GC8011@csclub.uwaterloo.ca> <4343E7AC.6000607@perkel.com> <20051005153727.994c4709.fmalita@gmail.com> <43442D19.4050005@perkel.com> <20051005195212.GJ7949@csclub.uwaterloo.ca>
In-Reply-To: <20051005195212.GJ7949@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: newton.ctyme.com - http://www.junkemailfilter.com"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Lennart Sorensen wrote:

>On Wed, Oct 05, 2005 at 12:44:25PM -0700, Marc Perkel wrote:
>  
>
>>What you don't get is that if you don't have rights to write to a file 
>>then you shouldn't have the right to delete the file.  Once you get past 
>>the "inside the box" Unix thinking you'll see the logic in this. So what 
>>if the process of deleting a file involves writing to it. That's not 
>>relevant.
>>    
>>
>
>When a system supports hardlinks, it IS relevant.
>
>So if I decide I want a link to a file like say /etc/group in my home
>dir (let us pretend they are on the same partition) so I make a hardlink
>to it in my home dir and end up with a file still owned by root (since I
>shouldn't be able to add me as owner to the file just by linking to it
>after all).  Should I now have to go bother the admin about deleting the
>file from my home dir if I decide that wasn't really what I wanted?  If
>I didn't have write permissions to the dir I wouldn't have been able to
>make the link in the first place, so since I made it I should be able to
>delete it, and I can with the unix way of doing things.  I still can't
>edit it anymore than I could in the original place since it linked with
>the new link to the file having the excact same permissions as the
>original.  Only someone like root can go chance the owner of a hardlink
>to someone else and start setting up some interesting file permissions
>using multiple hardlinks to one file.
>
>I suspect you can't do that on netware, so you would have to add
>explicit permissions for each user to a single copy of the file instead,
>and you would probably want them all to have read/write access but in
>fact NOT have delete permissions.
>
>Len Sorensen
>  
>
What you don't understand is that Netware's permissions mechanish is 
totally different that Linux. A hard link in Netware wouldn't inherit 
rights the way Linux does. So the user would have rights to their hard 
link to delete that link without having rights to unlink the file.

This is an important concept so pay attention. Linux stores all the 
permission to a file with that file entry. Netware doesn't. Netware 
calculates effective rights from the parent directories and it is all 
inherited unless files or directoies are explicitly set differently. So 
if files are added to other people folders then those people get rights 
to it automatically without having to go to the second step of changing 
the file's permissions.


-- 
Marc Perkel - marc@perkel.com

Spam Filter: http://www.junkemailfilter.com
    My Blog: http://marc.perkel.com

