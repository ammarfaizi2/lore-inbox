Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAFHgH>; Sat, 6 Jan 2001 02:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbRAFHf4>; Sat, 6 Jan 2001 02:35:56 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:7940 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129324AbRAFHfl>;
	Sat, 6 Jan 2001 02:35:41 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: georgek@netwrx1.com
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 Module compile error 
In-Reply-To: Your message of "Fri, 05 Jan 2001 11:23:29 MDT."
             <ek0c5t404dfib22jc6je0dldkj57e07k7d@4ax.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 06 Jan 2001 18:35:33 +1100
Message-ID: <17981.978766533@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Jan 2001 11:23:29 -0600, 
George R. Kasica <georgek@netwrx1.com> wrote:
>>make[1]: Nothing to be done for `modules_install'.
>>make[1]: Leaving directory `/usr/src/linux-2.4.0/arch/i386/lib'
>>cd /lib/modules/2.4.0; \
>>mkdir -p pcmcia; \
>>find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{}
>>pcmcia
>>if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.0; fi
>>depmod: /lib/modules//2.2.18/modules.dep is not an ELF file
>>depmod: error reading ELF header

You have a broken modules.conf that tells depmod to scan _all_ of
/lib/modules or you have an old version of modules or you have some
weird symlinks in /lib/modules.  It looks like you have some dangling
symlinks, although I cannot be certain about that.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
