Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263219AbTDBXqv>; Wed, 2 Apr 2003 18:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263245AbTDBXqv>; Wed, 2 Apr 2003 18:46:51 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:38101 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S263219AbTDBXqu>; Wed, 2 Apr 2003 18:46:50 -0500
Date: Wed, 02 Apr 2003 17:58:08 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.66-mm2] Fix page_convert_anon locking issues
Message-ID: <116640000.1049327888@baldur.austin.ibm.com>
In-Reply-To: <20030402155220.651a1005.akpm@digeo.com>
References: <8910000.1049303582@baldur.austin.ibm.com>
 <20030402132939.647c74a6.akpm@digeo.com>
 <80300000.1049320593@baldur.austin.ibm.com>
 <20030402150903.21765844.akpm@digeo.com>
 <102170000.1049325787@baldur.austin.ibm.com>
 <20030402153845.0770ef54.akpm@digeo.com>
 <110950000.1049326945@baldur.austin.ibm.com>
 <20030402155220.651a1005.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Wednesday, April 02, 2003 15:52:20 -0800 Andrew Morton
<akpm@digeo.com> wrote:

> hmmmm.  It also probably needs both compiler barriers and memory barriers.
> 
> It does give me creepy feelings.  I worry that because nobody uses
> remap_file_pages() yet, we will hit 2.6.25 before discovering that we have
> fundamental VM locking problems which affect $major$ applications.

It's looking more and more like we should use your other suggestion.  It's
definitely simpler if we can make it failsafe.  I'll code it up tomorrow.

Dave

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

