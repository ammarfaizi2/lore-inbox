Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262432AbTCMQbl>; Thu, 13 Mar 2003 11:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262451AbTCMQbl>; Thu, 13 Mar 2003 11:31:41 -0500
Received: from menelao.polito.it ([130.192.3.30]:25092 "HELO menelao.polito.it")
	by vger.kernel.org with SMTP id <S262432AbTCMQbe>;
	Thu, 13 Mar 2003 11:31:34 -0500
From: Willy Gardiol <gardiol@libero.it>
Reply-To: gardiol@libero.it
To: Jens Axboe <axboe@suse.de>, James Stevenson <james@stev.org>
Subject: Re: OOPS in 2.4.21-pre5, ide-scsi
Date: Thu, 13 Mar 2003 17:39:38 +0100
User-Agent: KMail/1.5
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
References: <20030227221017.4291c1f6.skraw@ithnet.com> <014b01c2e978$701050e0$0cfea8c0@ezdsp.com> <20030313163707.GH836@suse.de>
In-Reply-To: <20030313163707.GH836@suse.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_KRLc+7bRf5U2MaM"
Message-Id: <200303131739.39991.gardiol@libero.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_KRLc+7bRf5U2MaM
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: clearsigned data
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Do you thnik this can have somthing to share with the oops i am getting wit=
h=20
ide-scsi, a cd burner, DMA, and a PCI IDE controller?
I attach the oops decoded.

There is a thread about this on linux-ide, it seems a problem common at lea=
st=20
to another guy


Alle 17:37, gioved=EC 13 marzo 2003, Jens Axboe ha scritto:
> On Thu, Mar 13 2003, James Stevenson wrote:
> > Hi
> >
> > strange looks alot like the ones i have seen though the whole 2.4.x tre=
e.
> >
> > this was discussed before somebody said they would send a patch myself
> > and sombody else were going to test it but the patch never happens.
> >
> > >From what i can work out an error occurs on the cd drive and the reque=
st
> >
> > queue is then empty and the ide-scsi driver then attempts to access the
> > reuest queue that doesnt exist i never did manage to find out
> > where the request get removed from the queue though.
>
> Your explanation doesn't quite make sense, but I can take a look at the
> problem :-)
>
> What kernel is the below oops from? What compiler?
>
> > *pde =3D 00000000
> > Oops: 0000
> > CPU:    0
> > EIP:    0010:[<c01e5783>]    Not tainted
> > Using defaults from ksymoops -t elf32-i386 -a i386
> > EFLAGS: 00010202
> > eax: 00000000   ebx: c7a71000   ecx: c0327104   edx: 00000000
> > esi: 00000001   edi: c13a4fc0   ebp: cb23df58   esp: cb23df44
> > ds: 0018   es: 0018   ss: 0018
> > Process klogd (pid: 381, stackpage=3Dcb23d000)
> > Stack: 00000000 c0327294 c13de260 c0327294 00000202 cb23df78 c01cdd11
> > c0327294
> >        c01e5700 c0327104 c121db00 04000001 0000000f cb23df98 c010a0bd
> > 0000000f
> >        c13de260 cb23dfc4 cb23dfc4 0000000f c02f8ae0 cb23dfbc c010a24d
> > 0000000f
> > Call Trace: [<c01cdd11>] [<c01e5700>] [<c010a0bd>] [<c010a24d>]
> > [<c010c358>] Code: 8b 72 18 46 89 72 18 8b 55 f0 8b 82 f0 00 00 00 8b 58
> > 04 53
> >
> > >>EIP; c01e5783 <idescsi_pc_intr+83/290>   <=3D=3D=3D=3D=3D
> >
> > Trace; c01cdd11 <ide_intr+c1/120>
> > Trace; c01e5700 <idescsi_pc_intr+0/290>
> > Trace; c010a0bd <handle_IRQ_event+3d/70>
> > Trace; c010a24d <do_IRQ+7d/c0>
> > Trace; c010c358 <call_do_IRQ+5/d>
> > Code;  c01e5783 <idescsi_pc_intr+83/290>
> > 00000000 <_EIP>:
> > Code;  c01e5783 <idescsi_pc_intr+83/290>   <=3D=3D=3D=3D=3D
> >    0:   8b 72 18                  mov    0x18(%edx),%esi   <=3D=3D=3D=
=3D=3D
> > Code;  c01e5786 <idescsi_pc_intr+86/290>
> >    3:   46                        inc    %esi
> > Code;  c01e5787 <idescsi_pc_intr+87/290>
> >    4:   89 72 18                  mov    %esi,0x18(%edx)
> > Code;  c01e578a <idescsi_pc_intr+8a/290>
> >    7:   8b 55 f0                  mov    0xfffffff0(%ebp),%edx
> > Code;  c01e578d <idescsi_pc_intr+8d/290>
> >    a:   8b 82 f0 00 00 00         mov    0xf0(%edx),%eax
> > Code;  c01e5793 <idescsi_pc_intr+93/290>
> >   10:   8b 58 04                  mov    0x4(%eax),%ebx
> > Code;  c01e5796 <idescsi_pc_intr+96/290>
> >   13:   53                        push   %ebx
> >
> > <0>Kernel panic: Aiee, killing interrupt handler!
> >
> > 1 warning issued.  Results may not be reliable.

=2D --=20

!=20
 Willy Gardiol - gardiol@libero.it
 goemon.polito.it/~gardiol
 Use linux for your freedom.

   "La GPL e il modello open source consentono
    la creazione della tecologia migliore.
    Tutto qui."

      Linus Torvalds

=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+cLRLQ9qolN/zUk4RAhf0AJ0QrCS37i1zp1HuKFurga1SS1q4IQCfUqS+
bLL8Q7X5t2a967ANOs0i8iM=3D
=3DAH5R
=2D----END PGP SIGNATURE-----

--Boundary-00=_KRLc+7bRf5U2MaM
Content-Type: text/x-log;
  charset="iso-8859-1";
  name="ide-ops2.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ide-ops2.log"

cpu: 0, clocks: 2018136, slice: 1009068
cpu: 0, clocks: 2017929, slice: 1008964
Unable to handle kernel NULL pointer dereference at virtual address 00000018
c02093eb
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c02093eb>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013286
eax: c15d6dc0   ebx: c0348428   ecx: dc756f40   edx: dc756f40
esi: 00000000   edi: c0348428   ebp: 00000000   esp: c0301e90
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0301000)
Stack: c01e783c 000003e8 da246b40 c0108aae c15d6dc0 00000000 00000040 c0348428 
       c03482a8 c01e7c2a c0348428 00000000 00000000 00000088 000001f4 00000000 
       c03482a8 dc756f40 00000000 00000018 c0348428 c15f3280 c03482a8 dc756f40 
Call Trace:    [<c01e783c>] [<c0108aae>] [<c01e7c2a>] [<c01e7e25>] [<c01e810b>]
  [<c01e8020>] [<c01236fe>] [<c011fb02>] [<c011fa16>] [<c011f854>] [<c0108aae>]
  [<c0105360>] [<c010b018>] [<c0105360>] [<c0105383>] [<c01053f2>] [<c0105000>]
Code: 8b 56 18 89 70 04 8b 46 1c 8b 7e 0c c7 46 10 00 00 00 00 89 


>>EIP; c02093eb <idescsi_issue_pc+1b/1b0>   <=====

>>eax; c15d6dc0 <_end+128484c/204c0a8c>
>>ebx; c0348428 <ide_hwifs+808/20a8>
>>ecx; dc756f40 <_end+1c4049cc/204c0a8c>
>>edx; dc756f40 <_end+1c4049cc/204c0a8c>
>>edi; c0348428 <ide_hwifs+808/20a8>
>>esp; c0301e90 <init_task_union+1e90/2000>

Trace; c01e783c <ide_wait_stat+bc/130>
Trace; c0108aae <do_IRQ+9e/a0>
Trace; c01e7c2a <start_request+1ba/260>
Trace; c01e7e25 <ide_do_request+c5/1c0>
Trace; c01e810b <ide_timer_expiry+eb/1c0>
Trace; c01e8020 <ide_timer_expiry+0/1c0>
Trace; c01236fe <run_timer_list+ee/170>
Trace; c011fb02 <bh_action+22/40>
Trace; c011fa16 <tasklet_hi_action+46/70>
Trace; c011f854 <do_softirq+94/a0>
Trace; c0108aae <do_IRQ+9e/a0>
Trace; c0105360 <default_idle+0/30>
Trace; c010b018 <call_do_IRQ+5/d>
Trace; c0105360 <default_idle+0/30>
Trace; c0105383 <default_idle+23/30>
Trace; c01053f2 <cpu_idle+42/60>
Trace; c0105000 <_stext+0/0>

Code;  c02093eb <idescsi_issue_pc+1b/1b0>
00000000 <_EIP>:
Code;  c02093eb <idescsi_issue_pc+1b/1b0>   <=====
   0:   8b 56 18                  mov    0x18(%esi),%edx   <=====
Code;  c02093ee <idescsi_issue_pc+1e/1b0>
   3:   89 70 04                  mov    %esi,0x4(%eax)
Code;  c02093f1 <idescsi_issue_pc+21/1b0>
   6:   8b 46 1c                  mov    0x1c(%esi),%eax
Code;  c02093f4 <idescsi_issue_pc+24/1b0>
   9:   8b 7e 0c                  mov    0xc(%esi),%edi
Code;  c02093f7 <idescsi_issue_pc+27/1b0>
   c:   c7 46 10 00 00 00 00      movl   $0x0,0x10(%esi)
Code;  c02093fe <idescsi_issue_pc+2e/1b0>
  13:   89 00                     mov    %eax,(%eax)

 <0>Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.

--Boundary-00=_KRLc+7bRf5U2MaM--

