Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbUCOTSj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 14:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbUCOTSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 14:18:38 -0500
Received: from stgeorges-1-81-56-1-93.fbx.proxad.net ([81.56.1.93]:58826 "EHLO
	garfield") by vger.kernel.org with ESMTP id S262725AbUCOTS2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 14:18:28 -0500
Message-ID: <405601D4.8050504@free.fr>
Date: Mon, 15 Mar 2004 20:19:48 +0100
From: Fabian Fenaut <fabian.fenaut@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20040312 Debian/1.4.1-0jds1
X-Accept-Language: French/France, fr-FR, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.4-mm1 and -mm2: include/linux/version.h missing (vanilla
 ok)
References: <S262583AbUCOOfF/20040315143505Z+146@vger.kernel.org> <20040315174148.GA2163@mars.ravnborg.org> <4055F027.2070906@free.fr> <20040315184332.GA14464@mars.ravnborg.org>
In-Reply-To: <20040315184332.GA14464@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, it seems it was a debian-related problem. Make-kpkg runs "make
clean" _after_ compilation, and "make clean" from 2.6.4-mmX now deletes
version.h.

Workaround:
do_clean := NO
in /etc/kernel-pkg.conf (thanks to Juergen)

Thank you and sorry for the noise.

--
Fabian


Sam Ravnborg wrote:
> On Mon, Mar 15, 2004 at 07:04:23PM +0100, Fabian Fenaut wrote:
> 
>> And, to compile my modules successfully, I copied version.h from 
>> vanilla to /usr/src/2.6.4-mm2/include/linux (and modified it the 
>> correct way). Then I compiled my modules, and after that, my 
>> hand-made version.h is still here, so make-kpkg doesn't delete 
>> anything.
>> 
>> => version.h is _never_ created.
> 
> 
> Works for me - hmmm. 1) Could you check you have write access to 
> include/linux 2) Show the output of a make (please, no magic debian 
> shell scripts) 3) Set CLEAN_FILES equal nothing in top-level Makefile
>  and try again.
> 
> Please mail the result of the above.
> 
> Sam

