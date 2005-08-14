Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbVHNX0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbVHNX0A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 19:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbVHNX0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 19:26:00 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:50756 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932347AbVHNXZ7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 19:25:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XohbOBV+XeQOG8dJTi1lsz6cDt/jZRLX3+nGcnVMdXyU78xObRT/3iOfahwYcABqtpbvxfLGOxOYWwZOeNRWk9fbe/N23eVdThvN6icBrCWvbl9irsuXnVVMrka1MRHfzOs5yeArnrAJ78jeu6EMYQS5c+bFOQfM12kaQ09Z9BI=
Message-ID: <bda6d13a050814162519d6f2a8@mail.gmail.com>
Date: Sun, 14 Aug 2005 16:25:55 -0700
From: Joshua Hudson <joshudson@gmail.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: BSD jail
In-Reply-To: <20050814115651.GA6024@IBM-BWN8ZTBWA01.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <bda6d13a050812174768154ea5@mail.gmail.com>
	 <20050813143335.GA5044@IBM-BWN8ZTBWA01.austin.ibm.com>
	 <bda6d13a0508130933bdbc46a@mail.gmail.com>
	 <20050814115651.GA6024@IBM-BWN8ZTBWA01.austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Serge E. Hallyn (serue@us.ibm.com)
>Quoting Joshua Hudson (joshudson@gmail.com):
> Why would you want a virtual network device implementation? The whole
>
>So that a jailed process can use the net but can't use your network
>address (intercept ssh, imap/stunnel, etc).

[snip]

>But in the end vserver with read-only bind mounts seems a better way to
>go imo.
Latest version of linux vserver source: 100K bzipped
Latest version of linux-jail: 34K uncompressed

To build a virtual network device requires code for the device, code
for routing the device
in the kernel, some way to tell the router that this machine is hosted
through the host
machine's ethernet card, and control of which processes use which
network devices.

Way too much work for something intended to be simple and have essentially no
overhead.  All this work only gets jailed processes the ability to use
127.0.0.1.
The rest I can already do with eth0:1 and the specs for jail(2) from BSD.
