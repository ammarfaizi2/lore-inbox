Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264534AbUAVP16 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 10:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264901AbUAVP15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 10:27:57 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:28558 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264534AbUAVP1u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 10:27:50 -0500
In-Reply-To: <20040122150713.GC15271@stop.crashing.org>
References: <20040120172708.GN13454@stop.crashing.org> <200401211946.17969.amitkale@emsyssoft.com> <20040121153019.GR13454@stop.crashing.org> <200401212223.13347.amitkale@emsyssoft.com> <20040121184217.GU13454@stop.crashing.org> <20040121192128.GV13454@stop.crashing.org> <400F0759.5070309@mvista.com> <20040122150713.GC15271@stop.crashing.org>
Mime-Version: 1.0 (Apple Message framework v609)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <30216351-4CEF-11D8-A2A1-000A95A0560C@us.ibm.com>
Content-Transfer-Encoding: 7bit
Cc: KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       George Anzinger <george@mvista.com>,
       Powerpc Linux <linuxppc-dev@lists.linuxppc.org>,
       "Amit S. Kale" <amitkale@emsyssoft.com>
From: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: PPC KGDB changes and some help?
Date: Thu, 22 Jan 2004 09:25:19 -0600
To: Tom Rini <trini@kernel.crashing.org>
X-Mailer: Apple Mail (2.609)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 22, 2004, at 9:07 AM, Tom Rini wrote:
>
> On Wed, Jan 21, 2004 at 03:12:25PM -0800, George Anzinger wrote:
>
>> A question I have been meaning to ask:  Why is the arch/common 
>> connection
>> via a structure of addresses instead of just calls?  I seems to me 
>> that
>> just calling is a far cleaner way to do things here.  All the struct 
>> seems
>> to offer is a way to change the backend on the fly.  I don't thing we 
>> ever
>> want to do that.  Am I missing something?
>
> I imagine it's a style thing.  I don't have a preference either way.

I think we in PPC land have gotten used to that "style" because we have 
one kernel that supports different "platforms", i.e. it selects the 
appropriate code at runtime as George says. In general that's a little 
bit slower and a little bit bigger.

Unless you need to choose among PPC KGDB functions at runtime, which I 
don't think you do, you don't need it...

-- 
Hollis Blanchard
IBM Linux Technology Center

