Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWCXXMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWCXXMv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 18:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWCXXMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 18:12:50 -0500
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:52364 "EHLO
	mail7.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S964814AbWCXXMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 18:12:49 -0500
Date: Fri, 24 Mar 2006 18:12:46 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Michael Halcrow <mhalcrow@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, phillip@hellewell.homeip.net,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mcthomps@us.ibm.com,
       yoder1@us.ibm.com, toml@us.ibm.com, emilyr@us.ibm.com,
       daw@cs.berkeley.edu
Subject: Re: eCryptfs Design Document
In-Reply-To: <20060324222517.GA13688@us.ibm.com>
Message-ID: <Pine.LNX.4.64.0603241757090.27964@excalibur.intercode>
References: <20060324222517.GA13688@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Mar 2006, Michael Halcrow wrote:

> initialization vector by taking the MD5 sum of the file encryption
> key; the root IV is the first N bytes of that MD5 sum, where N is the
> number of bytes constituting an initialization vector for the cipher
> being used for the file (it is worth noting that known plaintext
> attacks against the MD5 hash algorithm do not affect the security of
> eCryptfs, since eCryptfs only hashes secret values).

What about other attacks on MD5?  Hard coding it into the system makes me 
nervous, what about making this selectable?

> By default, eCryptfs selects AES-128. Later versions of eCryptfs will 
> allow the user to select the cipher and key length.

Also, what about making the encryption mode selectable, to at least allow 
for like LRW support in addition to CBC?


- James
-- 
James Morris
<jmorris@namei.org>
