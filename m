Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424481AbWKKBU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424481AbWKKBU4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 20:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424484AbWKKBU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 20:20:56 -0500
Received: from gw.goop.org ([64.81.55.164]:56219 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1424481AbWKKBUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 20:20:55 -0500
Message-ID: <4555256F.2050006@goop.org>
Date: Fri, 10 Nov 2006 17:20:47 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: magnus.damm@gmail.com, horms@verge.net.au, ebiederm@xmission.com,
       magnus@valinux.co.jp, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com,
       ak@muc.de, fastboot@lists.osdl.org, anderson@redhat.com
Subject: Re: [PATCH 02/02] Elf: Align elf notes properly
References: <45550D2F.2070004@goop.org>	<20061110.153930.23011358.davem@davemloft.net>	<455518C6.8000905@goop.org> <20061110.164349.35665774.davem@davemloft.net>
In-Reply-To: <20061110.164349.35665774.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:
> We should be OK with the elf note header since n_namesz, n_descsz, and
> n_type are 32-bit types even on Elf64.  But for the contents embedded
> in the note, I am not convinced that there are no potential issues

PT_NOTE segments are not generally mmaped directly, nor are they
generally very large.  There should be no problem for a note-using
program to load/copy the notes into memory with appropriate alignment. 
I guess a lot of the contents of core elf notes are register dumps and
so on, so debuggers must be already dealing with this.

    J
