Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753068AbWKFQO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068AbWKFQO6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 11:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753181AbWKFQO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 11:14:57 -0500
Received: from nat-132.atmel.no ([80.232.32.132]:23248 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1753068AbWKFQO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 11:14:57 -0500
Date: Mon, 6 Nov 2006 17:13:46 +0100
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: vgoyal@in.ibm.com
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, maneesh@in.ibm.com
Subject: Re: [PATCH 7/11] i386: Kallsyms generate relocatable symbols
Message-ID: <20061106171346.6be95774@cad-250-152.norway.atmel.com>
In-Reply-To: <20061106160353.GD26091@in.ibm.com>
References: <20061023192456.GA13263@in.ibm.com>
	<20061023193748.GH13263@in.ibm.com>
	<20061106154857.003dc9d9@cad-250-152.norway.atmel.com>
	<20061106160353.GD26091@in.ibm.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2006 11:03:53 -0500
Vivek Goyal <vgoyal@in.ibm.com> wrote:

> On Mon, Nov 06, 2006 at 03:48:57PM +0100, Haavard Skinnemoen wrote:

> > kallsyms_addresses:
> >         PTR     _text + 0xffffffffffff4000
> >         PTR     _text + 0xffffffffffff4000
> > 
> > Any idea how to fix this? Could we introduce a new symbol that
> > always marks the start of the image perhaps?
> >
> 
> Hi Haavard,
> 
> Does the attached patch solve the issue for you?

Yes it does, thanks. I tested it by forcing a crash in a __init
function, and the resulting Oops looks correct.

Haavard
