Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161106AbVKRNBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161106AbVKRNBK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 08:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161107AbVKRNBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 08:01:10 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:24876 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161106AbVKRNBJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 08:01:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fUFj+D7aXWrtbKgfQL+EEsxGjAnTKTX9OZrTBhWrDxvTp6fHW3DY8EKqPrAuHrSaf1ak0sp0eOKU8ndO+99EROfgheDvRiLI1hVkiinaoSgM+g7CWKpe1ctGTWNFPFJjBUZ3hR7d8ta/jTvvOTJB3KZyfGsd0RH1VkNLQnkN2so=
Message-ID: <6880bed30511180501r1fd6edd1hc64258842b8b0567@mail.gmail.com>
Date: Fri, 18 Nov 2005 14:01:08 +0100
From: Bas Westerbaan <bas.westerbaan@gmail.com>
To: Arijit Das <Arijit.Das@synopsys.com>
Subject: Re: Does Linux has File Stream mapping support...?
Cc: 7eggert@gmx.de, linux-kernel@vger.kernel.org
In-Reply-To: <6880bed30511180459s66efa480y9a8c5f90b1bc73ac@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <7EC22963812B4F40AE780CF2F140AFE920906A@IN01WEMBX1.internal.synopsys.com>
	 <6880bed30511180459s66efa480y9a8c5f90b1bc73ac@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Or you could - more cleanly - do a replace through all your source
files (with an editor or a tool) which replaces printf with log (or
something similar) and implement that function with the code to write
to the log file and to stdout.

On 11/18/05, Bas Westerbaan <bas.westerbaan@gmail.com> wrote:
> Maybe an (ugly) way around it would be to simply use a parent process
> which captures the stdout of your compiler and writes it to the log
> file and prints it to its own stdout.
>
>
> On 11/18/05, Arijit Das <Arijit.Das@synopsys.com> wrote:
> > Ye...I know of tee.
> >
> > But the issue here is I have a HUGE Compiler (an Simulation tool) in which thousands of places there are "printf" statements to print messages to STDOUT stream. Now, a requirement came up which needs all those messages thrown to STDOUT also to be logged in a LOGFILE (in addition to STDOUT). Yes, this can be done through tee...but the usage model of the compiler doesn't leave that possibility open for me.
> >
> > So, am looking for a solution inside the Compiler code.
> >
> > Thanks,
> > Arijit
> >
> > -----Original Message-----
> > From: Bodo Eggert [mailto:harvested.in.lkml@7eggert.dyndns.org]
> > Sent: Friday, November 18, 2005 6:00 PM
> > To: Arijit Das; linux-kernel@vger.kernel.org
> > Subject: Re: Does Linux has File Stream mapping support...?
> >
> > Arijit Das <Arijit.Das@synopsys.com> wrote:
> >
> > > Is it possible to have File Stream Mapping in Linux? What I mean is
> > > this...
> > >
> > > FILE * fp1 = fopen("/foo", "w");
> > > FILE * fp2 = fopen("/bar", "w");
> > > FILE * fp_common = <Stream_Mapping_Func>(fp1, fp2);
> > >
> > > fprint(fp_common, "This should be written to both files ... /foo and
> > > /bar");
> >
> > It's a userspace problem. man "tee".
> >
> > Doing this in the kernel would be horrible.
> >
> > --
> > Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
> > verbreiteten Lügen zu sabotieren.
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
>
>
> --
> Bas Westerbaan
> http://blog.w-nz.com/
> GPG Public Keys: http://w-nz.com/keys/bas.westerbaan.asc
>


--
Bas Westerbaan
http://blog.w-nz.com/
GPG Public Keys: http://w-nz.com/keys/bas.westerbaan.asc
