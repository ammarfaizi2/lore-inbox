Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291869AbSBHWDS>; Fri, 8 Feb 2002 17:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291871AbSBHWDJ>; Fri, 8 Feb 2002 17:03:09 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:13065 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S291869AbSBHWC6>; Fri, 8 Feb 2002 17:02:58 -0500
Date: Fri, 8 Feb 2002 17:02:57 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: patch: aio + bio for raw io
Message-ID: <20020208170257.A12788@redhat.com>
In-Reply-To: <20020208025313.A11893@redhat.com> <20020208151009.A1810@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020208151009.A1810@in.ibm.com>; from suparna@in.ibm.com on Fri, Feb 08, 2002 at 03:10:09PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 03:10:09PM +0530, Suparna Bhattacharya wrote:
> You chose to add a kvec_cb field to the bio structure rather than use
> bi_private ?

Yup.  I'm lazy.  Also, the cb struct actually needs 2 pointers, so just 
bi_private isn't enough.

> For the raw path, you are OK since you never have to copy data out of 
> the kvecs after i/o completion, and unmap_kvec only looks at veclet pages. 
> So the fact block can change the offset and len fields in the veclets 
> doesn't affect you, but thought I'd mention it as a point of caution
> anyhow ...

Ugh.  That sounds like something bio should not be doing.  If someone 
wants to fix it, such a patch would be much appreciated, otherwise it'll 
wait until I'm back in Canada.

		-ben
