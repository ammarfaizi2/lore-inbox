Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbVHMQdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbVHMQdb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 12:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbVHMQdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 12:33:31 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:10581 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932183AbVHMQda convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 12:33:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KCo3ps49r7b181cKMqsCzxuk55FKrY4Qk3eUjUuiYBMN5jr4iFJ8OAqFT9gNNbIwo0Ru1G1jbP+KT3Fb8qpgCCH1CD00AZrMTzkwORGL+HjFeZ7CWZEo5vctlxRAptwRASST1rV40PTaAgy1ATseA+9kkKbjh0wiQZQATd9xbIk=
Message-ID: <bda6d13a0508130933bdbc46a@mail.gmail.com>
Date: Sat, 13 Aug 2005 09:33:29 -0700
From: Joshua Hudson <joshudson@gmail.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: BSD jail
In-Reply-To: <20050813143335.GA5044@IBM-BWN8ZTBWA01.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <bda6d13a050812174768154ea5@mail.gmail.com>
	 <20050813143335.GA5044@IBM-BWN8ZTBWA01.austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/05, Serge E. Hallyn <serue@us.ibm.com> wrote:
> The latest version (which is still quite old) is at
> http://www.sf.net/projects/linuxjail and does have ipv6 support.  The last
> time I submitted it, Christoph had objected to the way the networking was
> done in general.  I've tried twice to float a generalized "per-process
> network namespaces" patch, but haven't really found a good approach.
> 
> I suspect that the best approach would be to take the linux-vserver
> ngnet implementation and convert it to a standalone network namespace
> plus virtual network device implementation.  Do you care to give this
> a try?
> 
> thanks,
> -serge

Why would you want a virtual network device implementation? The whole
point of jail()
is a replacement for chroot() for housing untrusted root processes in
a lightweight
manner as reasonable.  I think in one way at least, I have restricted the manner
of jail behavior better than the current linuxjail, by turning off
capabilities rather than
blocking mknod(), mount(), etc.

I do like the idea of patching in through LSM, however not everything
can be done there.
In particular, I could escape from the jail as implemented there by a
classic chroot()
trick.
