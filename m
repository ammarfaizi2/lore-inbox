Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288962AbSAISW0>; Wed, 9 Jan 2002 13:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288961AbSAISWU>; Wed, 9 Jan 2002 13:22:20 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:33973 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S288957AbSAISWE>; Wed, 9 Jan 2002 13:22:04 -0500
Date: Wed, 9 Jan 2002 13:21:48 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br, andrea@suse.de
Subject: Re: [PATCH] PAGE_SIZE IO for RAW (RAW VARY)
Message-ID: <20020109132148.C12609@redhat.com>
In-Reply-To: <20020109125845.B12609@redhat.com> <200201091812.g09ICBF18477@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200201091812.g09ICBF18477@eng2.beaverton.ibm.com>; from pbadari@us.ibm.com on Wed, Jan 09, 2002 at 10:12:11AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 10:12:11AM -0800, Badari Pulavarty wrote:
> why ? could you explain ? I am not expecting that user buffer be aligned
> to PAGE_SIZE.

Okay, that part I misread from the message, but that leaves the question of 
"does it work?"  Iirc, Jeff Merkey tested variable sized ios with nwfs, but 
found that triggered bugs in the low level drivers, some of which assume that 
all buffer heads within a request have the same block size.  Given that 
concern, I really don't think this is a safe 2.4 patch.

		-ben
-- 
Fish.
