Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268119AbUJSMMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268119AbUJSMMt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 08:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268136AbUJSMMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 08:12:49 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:20232 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268119AbUJSMMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 08:12:44 -0400
Date: Tue, 19 Oct 2004 13:12:40 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: Fwd: [Bug 3592] New: pppd "IPCP: timeout sending Config-Requests"
Message-ID: <20041019131240.A20243@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can someone else look at this - I presently have no time for any
"community" work from the end of this week onwards, and shall be
bouncing all bugs to lkml.  I'm expecting this situation to continue
until maybe Christmas time.

I'm going to try to flush as much stuff from my patch queues as
possible for the remainder of this week, and then I think it'll
be up to others.

mbligh - please assign the default owner for:
- PCMCIA bugs to linux-pcmcia@lists.infradead.org
- serial bugs to, I guess, linux-kernel@vger.kernel.org

I'm not sure at present what's going to happen with "community"
ARM kernel work, but I think it will certainly not be progressing
very quickly.  I'll do what I can but I fear it won't be very much.

----- Forwarded message from bugme-daemon@osdl.org -----

Date: Tue, 19 Oct 2004 04:53:50 -0700
From: bugme-daemon@osdl.org
To: rmk@arm.linux.org.uk
Subject: [Bug 3592] New: pppd "IPCP: timeout sending Config-Requests"

http://bugme.osdl.org/show_bug.cgi?id=3592

           Summary: pppd "IPCP: timeout sending Config-Requests"
    Kernel Version: 2.6.9-rc4
            Status: NEW
          Severity: normal
             Owner: rmk@arm.linux.org.uk
         Submitter: vovan@planet.nl


Distribution: Gentoo
Hardware Environment: 
Software Environment: ppp-2.4.1 ( tested with ppp-2.4.2 - the same error )
Problem Description: With 2.6.9-rc4 I'm getting the error when dialing to my
provider. With older kernel versions everything works fine. After remote modem
cosed the connection (rcvd [CHAP Success id=0x29 ""]) pppd keeps sending
Config-Requests
sent [IPCP ConfReq id=0x1 <addr 192.168.1.2> <compress VJ 0f 01>]              
      
sent [CCP ConfReq id=0x1 <deflate 15> <deflate(old#) 15> <bsd v1 15>]

Steps to reproduce: 
1) Install kernel 2.6.9-rc4
2) use the following script to connect ( chap1 )
REPORT 'CONNECT'                                                               
                                        
ABORT 'BUSY'                                                                   
                                        
ABORT 'ERROR'                                                                  
                                        
ABORT 'NO ANSWER'                                                              
                                        
ABORT 'NO CARRIER'                                                             
                                        
ABORT 'NO DIALTONE'                                                            
                                        
ABORT 'Invalid Login'                                                          
                                        
ABORT 'Login incorrect'                                                        
                                        
TIMEOUT 45                                                                     
                                        
'' 'ATZ'                                                                       
                                        
'OK' 'ATS32=98'                                                                
                                        
'OK' 'ATS0=1'                                                                  
                                        
'OK' 'ATDT0*******'                                                            
                                      
'CONNECT' ''                                                                   
                                        
'~--' '' 
3) pppd command:
/usr/sbin/pppd debug nodetach lock modem crtscts asyncmap 00000000 mru 768 mtu
768 user username remotename NT4RAS /dev/ttyS4 115200 noauth linkname ppp0
connect /usr/sbin/chat -v -f /etc/ppp/chat1

------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.

----- End forwarded message -----

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
