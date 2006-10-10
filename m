Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030439AbWJJVb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030439AbWJJVb5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030440AbWJJVb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:31:57 -0400
Received: from smtp-out.google.com ([216.239.33.17]:3070 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030439AbWJJVb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:31:56 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=ZxpIBI1VTQTPxkrPLbGNZn7e1bSTyfx8GX1HTm6NKtjlY0YMxxAhGrHxwtWyyCC/K
	Dk5V43t/CGUiJoqSVc7uw==
Message-ID: <6599ad830610101431j33a5dc55h6878d5bc6db91e85@mail.gmail.com>
Date: Tue, 10 Oct 2006 14:31:43 -0700
From: "Paul Menage" <menage@google.com>
To: "Chandra Seetharaman" <sekharan@us.ibm.com>, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ckrm-tech] [PATCH 0/5] Allow more than PAGESIZE data read in configfs
In-Reply-To: <20061010203511.GF7911@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
	 <20061010203511.GF7911@ca-server1.us.oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/06, Joel Becker <Joel.Becker@oracle.com> wrote:
> On Tue, Oct 10, 2006 at 11:20:43AM -0700, Chandra Seetharaman wrote:
> > Currently, maximum amount of data that can be read from a configfs
> > attribute file is limited to PAGESIZE bytes. This is a limitation for
> > some of the usages of configfs.
>
>         NAK.  This forces a complex and inappropriate interface on the
> majority of users, and doesn't honor configfs' simplicity-first design.

How is the seq_file interface complex and inappropriate? For the
configfs clients it's basically a drop-in replacement for sprintf(),
as Chandra's patches show.

Paul
