Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265422AbUAPPmk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 10:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265445AbUAPPmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 10:42:39 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:53856 "EHLO
	thoron.boston.redhat.com") by vger.kernel.org with ESMTP
	id S265422AbUAPPmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 10:42:38 -0500
Date: Fri, 16 Jan 2004 10:42:36 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Mark Borgerding <mark@borgerding.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: AES cryptoloop corruption under recent -mm kernels
In-Reply-To: <4007F360.50905@borgerding.net>
Message-ID: <Xine.LNX.4.44.0401161039480.20623-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jan 2004, Mark Borgerding wrote:

>  From looking through the cryptoloop code, it looks like the IV for CBC
> mode is always the sector index.  It seems this could be weak against
> chosen plaintext attacks, as well as allowing an attacker to know which
> cipher blocks started any changes between two snapshots of the
> ciphertext.  I discuss ECB, since I wouldn't consider using it.

Eli Biham has suggested encrypting the sector numbers, see
http://people.redhat.com/jmorris/crypto/cryptoloop_eli_biham.txt



- James
-- 
James Morris
<jmorris@redhat.com>


