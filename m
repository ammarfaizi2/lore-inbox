Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285666AbSA2WtD>; Tue, 29 Jan 2002 17:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285516AbSA2Wsx>; Tue, 29 Jan 2002 17:48:53 -0500
Received: from ns.ithnet.com ([217.64.64.10]:36626 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S285352AbSA2Wsp>;
	Tue, 29 Jan 2002 17:48:45 -0500
Message-Id: <200201292247.XAA10273@webserver.ithnet.com>
Cc: Jeff Chua <jeffchua@silk.corp.fedex.com>, jdthood@mail.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>, sfr@canb.auug.org.au
Date: Tue, 29 Jan 2002 23:47:55 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
In-Reply-To: <104D80077517@vcnet.vc.cvut.cz>
Content-Transfer-Encoding: 7BIT
Subject: Re: 2.4.18-pre7 slow ... apm problem
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 29 Jan 02 at 20:36, Jeff Chua wrote:                             
> > On Mon, 28 Jan 2002, Thomas Hood wrote:                           
> >                                                                   
> > > Suggestion: Try setting the idle_threshold to a higher value,   
> > > e.g., 98.  (The default value is 95.)                           
> >                                                                   
> > With 98, "ping localhost" on "guest" os showed 2 responses, then  
pause for                                                             
> > few seconds, then response, ...                                   
> >                                                                   
> > With 95, I got the 1st response, then nothing. 98 seems better,   
but still                                                             
> > slow...                                                           
> >                                                                   
> > With 100, it's perfect.                                           
>                                                                     
> I've got an idea - if you were saying that ping host->guest is fine,
> but other way around it does not work. Can you apply                
> ftp://platan.vc.cvut.cz/pub/vmware/vmware-ws-1455-update5.tar.gz    
> to your VMware 3.x? Stock vmware-3.x modules use netif_rx() instead 
> of netif_rx_ni(), and so network bottom half was not run under some 
> conditions.                                                         
>                                                                     
> Patch also allows you to run VMware on 2.5.3-pre5, BTW.             
                                                                      
We are completely OT here, but anyway it may be common interest:      
                                                                      
Applying this patch makes some of my problems go. dos-box does no     
longer hang the whole guest system, but succeeds in 4 of 5 runs. If it
does not output anything inside the dos-window and I hit the          
fullscreen (ALT-ENTER) everything is normal, ALT-ENTER again shows the
correct win desktop with dos-box and correct output there.            
It is almost ok, it does not hang, only a minor quirk left.           
                                                                      
Thanks,                                                               
Stephan                                                               
                                                                      
                                                                      
