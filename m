Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVFAKNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVFAKNM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 06:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVFAKNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 06:13:05 -0400
Received: from nproxy.gmail.com ([64.233.182.199]:33512 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261184AbVFAKM5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 06:12:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l422eINCWxauhMpUHzxHd8L92XEsmGvsYGP76CYSDL7wlVEzkOde5IQxr6J1IzkdnWXbXy8nQXHnsIoOAPbUNBRhT8fvLroJIWJvSc9piFEG/Ml2ZQZ9dcNEtpT+GeZLDpFTZkwmnRJEecI3NR//kBwvoHroMEf+9znBxvMA26Q=
Message-ID: <2cd57c9005060103122b2bae36@mail.gmail.com>
Date: Wed, 1 Jun 2005 18:12:55 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: cotte@freenet.de
Subject: Re: [RFC/PATCH 0/5] add execute in place support
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       schwidefsky@de.ibm.com, akpm@osdl.org
In-Reply-To: <428216DF.8070205@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <428216DF.8070205@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/05, Carsten Otte <cotte@de.ibm.com> wrote:
> Folks,
> 
> this is the intro to a small series of patches that introduce execute
> in place into the I/O stack. File I/O to memory-backed block
> devices is performed directly, bypassing the page cache and io
> schedulers. On s390, we use this for block devices based on shared
> memory between multiple virtual machines. This is also useful on
> embedded systems where the block device is located on a flash chip.
> This work is a result of a prior discussion with Andrew Morton
> about my first implementation which basically was a filesystem
> derived from ext2.
> 
> As I'd like to aim for integration into -mm and vanilla later on,
> I'd like to encourage everyone to give it a read and provide
> feedback. All patches apply against git-head as of today.

I feel the name "execute in place" misleading. This is not the real
XIP, IMHO. Invent another term or be tolerant?
-- 
Coywolf Qi Hunt
http://ahbl.org/~coywolf/
