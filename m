Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315310AbSDWStF>; Tue, 23 Apr 2002 14:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315311AbSDWStE>; Tue, 23 Apr 2002 14:49:04 -0400
Received: from firewall.conet.cz ([213.175.54.250]:40710 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S315310AbSDWStE>; Tue, 23 Apr 2002 14:49:04 -0400
Message-ID: <3CC5AC60.40201@conet.cz>
Date: Tue, 23 Apr 2002 20:48:00 +0200
From: Libor Vanek <lists@conet.cz>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Alvaro Figueroa <fede2@fuerzag.ulatina.ac.cr>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Adding snapshot capability to Linux
In-Reply-To: <Pine.GSO.4.21.0204231041010.8087-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:

>You _can't_ get consistent snapshots without cooperation from fs.  LVM,
>EVMS, whatever.  Only filesystem knows what IO needs to be pushed to
>make what we have on device consistent and what IO needs to be held
>back.  Neither VFS nor device driver do not and can not have such
>knowledge - it depends both on fs layout and on implementation details.
>

My idea was to "catch" functions for writing to fs (file/metadata) and 
hold them till I copy file/metadata to snapshot. I thought that when 
done in the correct place this could work with virtualy any "normal" fs...

Libor


