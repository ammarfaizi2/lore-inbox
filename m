Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965230AbWECPpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965230AbWECPpW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 11:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965229AbWECPpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 11:45:21 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:39279 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965232AbWECPpU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 11:45:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WI/D+RTtFrDYo6kUtthor49t9EzZ+UZ6B5YkPOZxWUTFHeVBWZl0EVqT3x5dIuleRVUit5g9xawkSpUnCH6LR+yOrZ2bznoVzteUk6LNgPXYDDstwJSFf4NfIIBlClz3cMT+iSUIA8UCMP7zVjuJPMrOQlGRLlhL0qjBAwludN4=
Message-ID: <6934efce0605030845o6d313681x6b89bef71c28b3a9@mail.gmail.com>
Date: Wed, 3 May 2006 08:45:19 -0700
From: "Jared Hulbert" <jaredeh@gmail.com>
To: "David Woodhouse" <dwmw2@infradead.org>
Subject: Re: [RFC] Advanced XIP File System
Cc: "Josh Boyer" <jwboyer@gmail.com>, "Nicolas Pitre" <nico@cam.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1146658275.20773.8.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6934efce0605021453l31a438c4j7c429e6973ab4546@mail.gmail.com>
	 <625fc13d0605021756v7a8e0d7p1e9d8e4c810bc092@mail.gmail.com>
	 <Pine.LNX.4.64.0605022316550.28543@localhost.localdomain>
	 <625fc13d0605030341h2a105f49r2b1b610547e30022@mail.gmail.com>
	 <1146658275.20773.8.camel@pmac.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>We
> only need to mark those pages as absent in the page tables if we ever
> schedule to userspace while the flash is in a mode other than read mode.
> Then handle the page fault by switching the flash back or waiting for
> it.

Where would we do this?  In each MTD driver?  A new generic aops function?
