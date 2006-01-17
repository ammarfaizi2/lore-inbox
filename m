Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWAQLB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWAQLB6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 06:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWAQLB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 06:01:58 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:51652 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S932397AbWAQLB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 06:01:57 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@ocs.com.au>
To: mita@miraclelinux.com (Akinobu Mita)
cc: Jesper Juhl <jesper.juhl@gmail.com>, ak@suse.de,
       linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 3/4] compact print_symbol() output 
In-reply-to: Your message of "Tue, 17 Jan 2006 19:58:27 +0900."
             <20060117105826.GA24488@miraclelinux.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 17 Jan 2006 22:01:55 +1100
Message-ID: <10742.1137495715@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akinobu Mita (on Tue, 17 Jan 2006 19:58:27 +0900) wrote:
>On Tue, Jan 17, 2006 at 11:52:19AM +0100, Jesper Juhl wrote:
>> On 1/17/06, Keith Owens <kaos@ocs.com.au> wrote:
>> > Akinobu Mita (on Tue, 17 Jan 2006 19:15:55 +0900) wrote:
>> > >- remove symbolsize field
>> > >- change offset format from hexadecimal to decimal
>> >
>> > That is silly.  Almost every binutils tool prints offsets in hex,
>> > including objdump and gdb.  Printing the trace offset in decimal just
>> > makes more work for users to convert back to decimal to match up with
>> > all the other tools.
>> >
>> Agreed.
>> Also, hex output is shorter and often more natural for this type of data.
>> 
>
>In my vmlinux, 99.9% of the functions are smaller than 10000 bytes.
>
>10000 == 0x2710
>So. strlen("10000") == 5 < strlen("0x2710") == 6
>Therefore call trace must be more compact.

Which is irrelevant when your change makes more work for everybody who
reads the trace.

