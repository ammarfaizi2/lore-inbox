Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265542AbSKABKh>; Thu, 31 Oct 2002 20:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265543AbSKABKh>; Thu, 31 Oct 2002 20:10:37 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:32275 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265542AbSKABKg>;
	Thu, 31 Oct 2002 20:10:36 -0500
Date: Thu, 31 Oct 2002 17:13:58 -0800
From: Greg KH <greg@kroah.com>
To: "KOCHI, Takayoshi" <t-kouchi@mvf.biglobe.ne.jp>
Cc: andrew.grover@intel.com, jung-ik.lee@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: bare pci configuration access functions ?
Message-ID: <20021101011358.GF12405@kroah.com>
References: <20021101083717.IAAOC0A82650.6C9EC293@mvf.biglobe.ne.jp> <20021031235457.GF10689@kroah.com> <20021101092358.JADUC0A8264C.1C79D883@mvf.biglobe.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021101092358.JADUC0A8264C.1C79D883@mvf.biglobe.ne.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 04:23:56PM -0800, KOCHI, Takayoshi wrote:
> 
> On Thu, 31 Oct 2002 15:54:57 -0800
> Greg KH <greg@kroah.com> wrote:
> 
> > > That's the way ACPI driver designers took and Linux can benefit
> > > from other OS's feedback in OS-independent part.
> > 
> > Can I ask if any of the development for other OSs has actually helped
> > Linux development?  I'm just curious.
> 
> FreeBSD's acpi project is a good example.
> http://www.jp.freebsd.org/acpi/index.html
> (though this page doesn't seem to reflect recent status)
> 
> They share the same code base (OS-independent part) as Linux
> and troubles FreeBSD had are troubles Linux will have or vice versa.
> 
> Its mailing-list is based in Japan but most discussions
> are in English and some intel developers are also in the list.

Nice, thanks for pointing that out.  But what about the fact that I
think we can now start optimizing certain parts of the "generic" code to
play nicer with Linux?

> AFAIK the aic7xxx driver has similar structure.

Some other SCSI drivers have this kind of structure.  And in the end,
it's a big pain.  If it makes the aic7xxx driver author's life easier,
all the better, as he's doing that work.  I just hope the upcoming 2.5
scsi core changes will not mess with him too much.

And that's the biggest problem with portions of code that try to be "os
independent", it usually causes bloat, and keeps other developers from
trying to help out with the project (any change I would make would most
likely be a Linux specific change, and be refused by the maintainer.)
It requires yet another "shim" layer between the driver's core logic,
and the OS, and the kernel sure doesn't need anymore of those...

OS independent drivers have been proven to not work, you don't see UDI
in production use now do you?

Now I don't mean this to be an ACPI rant, I know why they did their code
this way, and without it, there probably would not be any ACPI Linux
code.  I just don't think it's the best way (from an engineering
standpoint) to do things.  And again, we are getting way off topic from
the original problem, sorry.

thanks,

greg k-h
