Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262223AbVCHXhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbVCHXhV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 18:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbVCHXcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 18:32:33 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:2828 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262206AbVCHXa2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 18:30:28 -0500
From: Kristian =?iso-8859-1?q?S=F8rensen?= <ks@cs.aau.dk>
Organization: Aalborg University
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Subject: Re: Reading large /proc entry from kernel module
User-Agent: KMail/1.7.2
References: <200503081445.56237.ks@cs.aau.dk> <16942.12134.913207.508414@wombat.chubb.wattle.id.au>
In-Reply-To: <16942.12134.913207.508414@wombat.chubb.wattle.id.au>
MIME-Version: 1.0
Content-Disposition: inline
Date: Wed, 9 Mar 2005 00:31:17 +0100
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200503090031.17502.ks@cs.aau.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 March 2005 00:04, Peter Chubb wrote:
> >>>>> "Kristian" == Kristian Sørensen <ks@cs.aau.dk> writes:
>
> Kristian> Hi all!  I have some trouble reading a 2346 byte /proc entry
> Kristian> from our Umbrella kernel module.
>
>
> Kristian> static int umb_proc_write(struct file *file, const char *buffer,
> Kristian>                          unsigned long count, void *data) {
> Kristian>	char *policy;
> Kristian>	int *lbuf;
> Kristian>	int i;
>
> Here's your problem:  lbuf should be a char * not an int *.
> When you look lbuf[0] you'll get the first four characters packed
> into the int.
Okay, thanks! :-D That solves the first error :)

However, I still only get the the first 1003 characters, when I traverse the 
buffer :-/

-- 
Kristian Sørensen
E-mail: ipqw@users.sf.net, Phone: +45 29723816
