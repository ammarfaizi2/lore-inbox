Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312962AbSGPJdQ>; Tue, 16 Jul 2002 05:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312973AbSGPJdP>; Tue, 16 Jul 2002 05:33:15 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:13531 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S312962AbSGPJdP> convert rfc822-to-8bit; Tue, 16 Jul 2002 05:33:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Patrick Mochel <mochel@osdl.org>
Subject: Re: Driver reference counting and locking, again
Date: Tue, 16 Jul 2002 11:38:44 +0200
User-Agent: KMail/1.4.1
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0207151743100.14360-100000@geena.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.33.0207151743100.14360-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207161138.44246.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 16. Juli 2002 02:56 schrieb Patrick Mochel:
> Ok, here is another stab at trying to get reference counting and locking
> right for drivers.
>
> The short of it is that struct device_driver gets an owner field, which
> should be initialized to THIS_MODULE in the driver.

In your implementation it would seem that get_driver can suceed while
remove_driver is already running and the deletion from bus_list has
already happened.

	Regards
		Oliver



