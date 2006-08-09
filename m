Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030339AbWHIEBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbWHIEBJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 00:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030346AbWHIEBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 00:01:09 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:18536 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030339AbWHIEBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 00:01:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SGCLihcYbU50jPYhlp5/Wtp1/6HxyyJWFkiCIbEE0va3mPSUWdd/0XDrkSoF2M8YcfjSyWEaOtAZV49cXQvcC93diAtxBom137HGvXkS+kkF5/JVFXts4dvXzPM4fjO49bpvc2wvu1s/ayqwtnN3Lo6AvsnYhHP2l9vcUIhlnNE=
Message-ID: <787b0d920608082101h2f1c1200rf94be91eefdcdac0@mail.gmail.com>
Date: Wed, 9 Aug 2006 00:01:06 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: sds@tycho.nsa.gov, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       davem@redhat.com, viro@ftp.linux.org.uk
Subject: Re: How to lock current->signal->tty
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley writes:

> SELinux is just revalidating access to the tty when the task
> changes contexts upon execve, and resetting the tty if the
> task is no longer allowed to use it.  Likewise with the open
> file descriptors that would be inherited.  No clearing of the
> ttys of other tasks required as far as SELinux is concerned,
> although that might not fit with normal semantics.

If the process goes back to the old context after a second
execve or via special rights, it ought regain access to the tty.

(just block access instead of resetting the tty)
