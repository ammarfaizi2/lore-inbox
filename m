Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968429AbWLEQ27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968429AbWLEQ27 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 11:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968430AbWLEQ27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 11:28:59 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:32366 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968429AbWLEQ26 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 11:28:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HO0LNRMjfDOc8OogsZU4LUOzp35XoJ4ghBL0CKJLvPPM3I8hFi7OTo4eE207Ar9rjptS/pyOv4KVjiK7PlPnmgByLBtwYBTzkYNAEvfv2eQFGuqO4nj2xVVdfgOvJ91eGQJFJTyZYmscXucwnvvYvj4ZJ0rbbuWpi8VYJlUiB8c=
Message-ID: <2c0942db0612050828s1780acefu53dcfd31c88116c0@mail.gmail.com>
Date: Tue, 5 Dec 2006 08:28:55 -0800
From: "Ray Lee" <madrabbit@gmail.com>
Reply-To: ray-gmail@madrabbit.org
To: "=?ISO-8859-1?Q?Kristian_H=F8gsberg?=" <krh@redhat.com>
Subject: Re: [PATCH 0/3] New firewire stack
Cc: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org,
       "Stefan Richter" <stefanr@s5r6.in-berlin.de>
In-Reply-To: <45750FB6.8000304@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com>
	 <1165297363.29784.54.camel@localhost.localdomain>
	 <45750FB6.8000304@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/06, Kristian Høgsberg <krh@redhat.com> wrote:
> Ok... I was planning to make big-endian versions of the structs so that the
> endian issue would be solved.  But if the bit layout is not consistent, I
> guess bitfields are useless for wire formats.  I didn't know that though, I
> thought the C standard specified that the compiler should allocate bits out of
> a word using the lower bits first.

The C standard explicitly allows it to be implementation defined.
Having been bit by this exact problem, I can also recommend never
using bitfields for anything other than things kept solely in local
memory.

Ray
