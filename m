Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314136AbSD2RxZ>; Mon, 29 Apr 2002 13:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314140AbSD2RxY>; Mon, 29 Apr 2002 13:53:24 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:13481 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S314136AbSD2RxX>; Mon, 29 Apr 2002 13:53:23 -0400
Message-ID: <3CCD884D.70009@us.ibm.com>
Date: Mon, 29 Apr 2002 10:52:13 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: devfs: BKL *not* taken while opening devices
In-Reply-To: <Pine.LNX.4.21.0204291937430.23113-100000@serv>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
 > The BKL doesn't make a driver safe, remember that it's released on
 > schedule.

Not safe, but _safer_, and definitely safe enough for almost all uses. 
Some of the drivers rely on the fact that open() cannot be run 
concurrently.  The BKL does provide this if open never blocks.

-- 
Dave Hansen
haveblue@us.ibm.com

