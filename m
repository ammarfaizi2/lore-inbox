Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbTENOvK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 10:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbTENOvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 10:51:10 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:54641 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id S262382AbTENOvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 10:51:03 -0400
Date: Wed, 14 May 2003 10:02:56 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
cc: wli@holomorphy.com, mika.penttila@kolumbus.fi, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: Race between vmtruncate and mapped areas?
Message-ID: <18730000.1052924576@baldur.austin.ibm.com>
In-Reply-To: <20030513181022.6dbc5418.akpm@digeo.com>
References: <154080000.1052858685@baldur.austin.ibm.com>
 <3EC15C6D.1040403@kolumbus.fi><199610000.1052864784@baldur.austin.ibm.com>
 <20030513224929.GX8978@holomorphy.com>
 <220550000.1052866808@baldur.austin.ibm.com>
 <20030513181022.6dbc5418.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Tuesday, May 13, 2003 18:10:22 -0700 Andrew Morton <akpm@digeo.com>
wrote:

>>  Can anyone think of any gotchas to this solution?
> 
> mmap_sem nests outside i_shared_sem.

Rats.  You're right.  Time to consider alternatives.

Dave

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

