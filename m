Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288051AbSAMT4Y>; Sun, 13 Jan 2002 14:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288059AbSAMT4O>; Sun, 13 Jan 2002 14:56:14 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31809 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S288051AbSAMT4L>; Sun, 13 Jan 2002 14:56:11 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: initramfs buffer spec -- second draft
In-Reply-To: <a1oqmm$is3$1@cesium.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Jan 2002 12:53:26 -0700
In-Reply-To: <a1oqmm$is3$1@cesium.transmeta.com>
Message-ID: <m1ofjyqb7t.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> This is an update to the initramfs buffer format spec I posted
> earlier.  The changes are as follows:

Comments.  Endian issues are not specified, is the data little, big
or vax endian?

What is the point of alignment?  If the data starts as 4 byte aligned,
the 6 byte magic string guarantees the data will be only 2 byte
aligned.  This isn't good for 32 or 64 bit architectures.

I do like having a c_magic that at least allows us to change things
in the future if necessary.

Eric
