Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262802AbSJ1BRX>; Sun, 27 Oct 2002 20:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262803AbSJ1BRX>; Sun, 27 Oct 2002 20:17:23 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:38898 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S262802AbSJ1BRW>; Sun, 27 Oct 2002 20:17:22 -0500
Message-ID: <3DBC9194.5090006@nortelnetworks.com>
Date: Sun, 27 Oct 2002 20:23:32 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New nanosecond stat patch for 2.5.44
References: <20021027121318.GA2249@averell> <20021027214913.GA17533@clusterfs.com> <aphqqo$261$1@cesium.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:

> We probably need to revamp struct stat anyway, to support a larger
> dev_t, and possibly a larger ino_t (we should account for 64-bit ino_t
> at least if we have to redesign the structure.)  At that point I would
> really like to advocate for int64_t ts_sec and uint32_t ts_nsec and
> quite possibly a int32_t ts_taidelta to deal with leap seconds... I'd
> personally like struct timespec to look like the above everywhere.

For filesystems can we get away with just the 64-bit nanoseconds?  By my 
calculations that gives something like 584 years--do we need to worry 
about files older than that?

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

