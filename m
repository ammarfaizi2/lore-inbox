Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRAIMSb>; Tue, 9 Jan 2001 07:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129773AbRAIMSV>; Tue, 9 Jan 2001 07:18:21 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:15089 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129710AbRAIMSM>; Tue, 9 Jan 2001 07:18:12 -0500
Date: Tue, 9 Jan 2001 08:06:02 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Pauline Middelink <middelin@polyware.nl>, linux-kernel@vger.kernel.org,
        linux@advansys.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] advansys.c: include missing restore_flags, etc
Message-ID: <20010109080602.B21057@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Pauline Middelink <middelin@polyware.nl>,
	linux-kernel@vger.kernel.org, linux@advansys.com,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20010108201103.E17087@conectiva.com.br> <20010108202533.F17087@conectiva.com.br> <20010108203002.H17087@conectiva.com.br> <20010109001443.A20786@conectiva.com.br> <20010109083007.A24914@polyware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010109083007.A24914@polyware.nl>; from middelink@polyware.nl on Tue, Jan 09, 2001 at 08:30:07AM +0100
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 09, 2001 at 08:30:07AM +0100, Pauline Middelink escreveu:
> > +STATIC unsigned long
> >  DvcEnterCritical(void)
> >  {
> > -    int    flags;
> > +    unsigned long flags;
> >  
> >      save_flags(flags);
> >      cli();
> > @@ -9965,7 +9972,7 @@
> >  }
> 
> Err, according tho wise ppl on this list, this does not work on
> MIPSes. The flags thing must stay in the same stackframe.
> 
> (I know, not your fault, but since you are patching the driver...)

yap, know that, just thought that this beast was only for i386, will submit
another patch, and I think that some other drivers does this as well...

- Arnaldo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
