Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbUFCI2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbUFCI2J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 04:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbUFCI2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 04:28:09 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:14861 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261793AbUFCI2E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 04:28:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: William Lee Irwin III <wli@holomorphy.com>, Matt Mackall <mpm@selenic.com>
Subject: Re: [1/2] use const in time.h unit conversion functions
Date: Thu, 3 Jun 2004 11:17:09 +0300
X-Mailer: KMail [version 1.4]
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       suparna@in.ibm.com, linux-aio@kvack.org
References: <20040601021539.413a7ad7.akpm@osdl.org> <20040602184335.GC5414@waste.org> <20040602185205.GX21007@holomorphy.com>
In-Reply-To: <20040602185205.GX21007@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200406031117.09678.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 June 2004 21:52, William Lee Irwin III wrote:
> On Wed, Jun 02, 2004 at 01:43:35PM -0500, Matt Mackall wrote:
> > This is the second const-correctness patch I've seen in a couple days,
> > and I'd like to point out that while it's a noble cause, retrofitting
> > const decls onto interfaces is notorious for causing ripple effects in
> > APIs.
>
> There's a point to this one. A warning got tripped when const stuff was
> passed to it in patch #2, hence this as a preparatory cleanup.

If you get warnings in this:

const int c=5;
void f(int i);
void g() {
    f(c);
}

then you see compiler bug. Warning is ok in

const int c=5;
void f(int* i);
void g() {
    f(&c);
}

case.
-- 
vda
