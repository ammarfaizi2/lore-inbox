Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268787AbRHAG7W>; Wed, 1 Aug 2001 02:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268788AbRHAG7L>; Wed, 1 Aug 2001 02:59:11 -0400
Received: from tierra.stl.es ([195.235.83.3]:51045 "EHLO tierra.stl.es")
	by vger.kernel.org with ESMTP id <S268787AbRHAG6x>;
	Wed, 1 Aug 2001 02:58:53 -0400
Message-ID: <3B67A7B6.EE7B7931@stl.es>
Date: Wed, 01 Aug 2001 08:54:46 +0200
From: Julio =?iso-8859-1?Q?S=E1nchez=20Fern=E1ndez?= <j_sanchez@stl.es>
Organization: Poca
X-Mailer: Mozilla 4.75 [en]C-STL/0.3  (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Nerijus Baliunas <nerijus@users.sourceforge.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Transparent proxies and binding to foreign addresses
In-Reply-To: <m2lmlcakrq.fsf@j-sanchez-p.stl.es>
		<m2lmlcakrq.fsf@j-sanchez-p.stl.es>
		<200107270215.EAA1376016@mail.takas.lt>
	 <m2hevyaljp.fsf@j-sanchez-p.stl.es> <200107311820.UAA1709621@mail.takas.lt>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



Nerijus Baliunas wrote:
> 
> On 27 Jul 2001 09:16:58 +0200 Julio Sanchez Fernandez <j_sanchez@stl.es> wrote:
> 
> JSF> And as long as you don't care what origin address the server sees,
> JSF> that's alright.  But all connections now seem to come from the proxy.
> JSF> And that does not let you do things like differentiated services,
> JSF> access control or audit.  Even user support becomes a mess.
> 
> Do you mean that even if I adapt them as you say, the receiving end will see
> connection orriginating from the proxy instead of the real address?

Precisely.  The bind-to-foreign-address will usually fail.  If you set
/proc/sys/net/ipv4/ip_nonlocal_bind to "1", then the bind will succeed but
when you connect it will fail immedaiately or not work (I have not checked
the exact behaviour and I am still digging in the code).

> I'm asking as these 2 port forwarders I tried work with 2.4 kernel in non-transparent
> mode, i.e. connections seem to come from the proxy, what I need is connection
> to be seen to come from real originating IP.

So do I.  If you are the daring type, I suggest you track the netfilter-devel
mail list (start from http://lists.samba.org/mailman/listinfo/netfilter-devel)
where some discussion has happened in July.  If you are not, I am afraid you
will have to stay at 2.2.x for the time being.

Julio
