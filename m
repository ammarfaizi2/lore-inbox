Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbVJGAdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbVJGAdQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 20:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbVJGAdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 20:33:16 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:24812 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932229AbVJGAdP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 20:33:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h6FRVMUG24Jn74KJfVLcw0H3jrls4RopwBdmvX8PAMRKzdWEGg13xQPI/upfkZTDnfqWqXBQGdSQcjUjBeduEbEYOOCQhcwFL2JEwCRj/2GzZiI9IpKX8o7SzB4v+sZWTan6+IwUV5OrGdhut3pxhWOQL5ZltXhjFKrDclU6C0s=
Message-ID: <1e62d1370510061733q6fc71353g1f551dec12cac53d@mail.gmail.com>
Date: Fri, 7 Oct 2005 05:33:14 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
Reply-To: Fawad Lateef <fawadlateef@gmail.com>
To: Redes II <redes2k@gmail.com>
Subject: Re: 2.6.13 kernel_thread() question
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <bac30fa90510041742w558f4e55n@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <bac30fa90510041742w558f4e55n@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/05, Redes II <redes2k@gmail.com> wrote:
> Hello,
> Does kernel_thread detach the new Kernel thread from its parent?

AFAIR kernel_thread won't detach thread from its parent, for this you
have to explicitely call reparent_to_init

> Does something like pthread_detach(tid) exist in Kernel module's programming?

I think no, as there isn't any seperate memory for the kernel threads,
so no need for memory resources consumed by tid will be freed
immediately when tid terminates .... (CMIIW)



--
Fawad Lateef
